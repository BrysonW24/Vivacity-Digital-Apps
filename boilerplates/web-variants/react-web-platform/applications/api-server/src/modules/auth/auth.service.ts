import { Injectable, UnauthorizedException } from '@nestjs/common'
import { JwtService } from '@nestjs/jwt'
import { ConfigService } from '@nestjs/config'
import { PrismaService } from '../../database/prisma.service'
import { UsersService } from '../users/users.service'
import { RegisterDto, AuthResponseDto } from './dto'
import { UserEntity } from '../users/entities/user.entity'
import * as bcrypt from 'bcrypt'
import { v4 as uuidv4 } from 'uuid'

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private usersService: UsersService,
    private jwtService: JwtService,
    private configService: ConfigService
  ) {}

  async register(registerDto: RegisterDto): Promise<AuthResponseDto> {
    // Create user
    const user = await this.usersService.create(registerDto)

    // Generate tokens
    const { accessToken, refreshToken } = await this.generateTokens(user)

    return {
      accessToken,
      refreshToken,
      user,
    }
  }

  async login(user: UserEntity): Promise<AuthResponseDto> {
    const { accessToken, refreshToken } = await this.generateTokens(user)

    return {
      accessToken,
      refreshToken,
      user,
    }
  }

  async validateUser(email: string, password: string): Promise<UserEntity | null> {
    return this.usersService.validateUserPassword(email, password)
  }

  async refreshToken(token: string): Promise<AuthResponseDto> {
    // Find refresh token in database
    const refreshToken = await this.prisma.refreshToken.findUnique({
      where: { token },
      include: { user: true },
    })

    if (!refreshToken) {
      throw new UnauthorizedException('Invalid refresh token')
    }

    // Check if token is expired
    if (new Date() > refreshToken.expiresAt) {
      // Delete expired token
      await this.prisma.refreshToken.delete({
        where: { id: refreshToken.id },
      })
      throw new UnauthorizedException('Refresh token expired')
    }

    // Check if user is still active
    if (!refreshToken.user.isActive) {
      throw new UnauthorizedException('User is inactive')
    }

    // Delete old refresh token
    await this.prisma.refreshToken.delete({
      where: { id: refreshToken.id },
    })

    // Generate new tokens
    const user = new UserEntity(refreshToken.user)
    const tokens = await this.generateTokens(user)

    return {
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
      user,
    }
  }

  async logout(token: string): Promise<void> {
    // Delete refresh token from database
    await this.prisma.refreshToken.deleteMany({
      where: { token },
    })
  }

  private async generateTokens(user: UserEntity): Promise<{
    accessToken: string
    refreshToken: string
  }> {
    const payload = {
      sub: user.id,
      email: user.email,
      role: user.role,
    }

    // Generate access token
    const accessToken = this.jwtService.sign(payload, {
      expiresIn: this.configService.get<string>('JWT_EXPIRES_IN') || '15m',
    })

    // Generate refresh token
    const refreshToken = uuidv4()
    const refreshTokenExpiresIn =
      this.configService.get<string>('REFRESH_TOKEN_EXPIRES_IN') || '7d'

    // Calculate expiration date
    const expiresAt = new Date()
    const days = parseInt(refreshTokenExpiresIn.replace('d', ''))
    expiresAt.setDate(expiresAt.getDate() + days)

    // Save refresh token to database
    await this.prisma.refreshToken.create({
      data: {
        token: refreshToken,
        userId: user.id,
        expiresAt,
      },
    })

    return {
      accessToken,
      refreshToken,
    }
  }
}
