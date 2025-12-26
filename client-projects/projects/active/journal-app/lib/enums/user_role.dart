/// User Role Enum
///
/// Represents different user roles in the application with permission hierarchy.
enum UserRole {
  guest,
  user,
  moderator,
  admin,
  superAdmin,
  system,
}

extension UserRoleExtension on UserRole {
  /// Get role priority (higher number = more permissions)
  int get priority {
    switch (this) {
      case UserRole.guest:
        return 0;
      case UserRole.user:
        return 1;
      case UserRole.moderator:
        return 2;
      case UserRole.admin:
        return 3;
      case UserRole.superAdmin:
        return 4;
      case UserRole.system:
        return 5;
    }
  }

  /// Check if user has admin or higher permissions
  bool get isAdmin => this.priority >= UserRole.admin.priority;

  /// Check if user has moderator or higher permissions
  bool get isModerator => this.priority >= UserRole.moderator.priority;

  /// Check if user is authenticated (not guest)
  bool get isAuthenticated => this != UserRole.guest;

  /// Get display name for role
  String get displayName {
    switch (this) {
      case UserRole.guest:
        return 'Guest';
      case UserRole.user:
        return 'User';
      case UserRole.moderator:
        return 'Moderator';
      case UserRole.admin:
        return 'Admin';
      case UserRole.superAdmin:
        return 'Super Admin';
      case UserRole.system:
        return 'System';
    }
  }

  /// Check if role has specific permission
  bool hasPermission(String permission) {
    if (this == UserRole.superAdmin || this == UserRole.system) {
      return true; // Super admins and system have all permissions
    }

    switch (this) {
      case UserRole.admin:
        return !permission.contains('system');
      case UserRole.moderator:
        return ['view', 'comment', 'moderate'].any(
          (p) => permission.contains(p),
        );
      case UserRole.user:
        return ['view', 'create', 'edit_own'].any(
          (p) => permission.contains(p),
        );
      case UserRole.guest:
        return ['view'].any((p) => permission.contains(p));
      default:
        return false;
    }
  }
}
