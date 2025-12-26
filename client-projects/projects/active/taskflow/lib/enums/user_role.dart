/// User role enumeration
enum UserRole {
  guest,
  user,
  premium,
  moderator,
  admin,
  superAdmin,
}

extension UserRoleX on UserRole {
  bool get isGuest => this == UserRole.guest;
  bool get isUser => this == UserRole.user;
  bool get isPremium => this == UserRole.premium;
  bool get isModerator => this == UserRole.moderator;
  bool get isAdmin => this == UserRole.admin;
  bool get isSuperAdmin => this == UserRole.superAdmin;
  bool get hasAdminPrivileges => isAdmin || isSuperAdmin;
  bool get hasModerationPrivileges => isModerator || isAdmin || isSuperAdmin;

  String get displayName {
    switch (this) {
      case UserRole.guest:
        return 'Guest';
      case UserRole.user:
        return 'User';
      case UserRole.premium:
        return 'Premium';
      case UserRole.moderator:
        return 'Moderator';
      case UserRole.admin:
        return 'Admin';
      case UserRole.superAdmin:
        return 'Super Admin';
    }
  }

  static UserRole fromString(String value) {
    switch (value.toLowerCase()) {
      case 'guest':
        return UserRole.guest;
      case 'user':
        return UserRole.user;
      case 'premium':
        return UserRole.premium;
      case 'moderator':
        return UserRole.moderator;
      case 'admin':
        return UserRole.admin;
      case 'superadmin':
        return UserRole.superAdmin;
      default:
        return UserRole.user;
    }
  }
}
