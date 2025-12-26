/// All UI strings and i18n keys
/// Centralized text management for easy translation and consistency

class AppStrings {
  // ==================== Common ====================
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String retry = 'Retry';
  static const String close = 'Close';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String logout = 'Logout';

  // ==================== Auth ====================
  static const String welcome = 'Welcome';
  static const String login = 'Log In';
  static const String signup = 'Sign Up';
  static const String createAccount = 'Create Account';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String dontHaveAccount = "Don't have an account?";
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String rememberMe = 'Remember me';
  static const String signIn = 'Sign In';
  static const String signUp = 'Sign Up';
  static const String resetPassword = 'Reset Password';
  static const String sendResetLink = 'Send Reset Link';
  static const String backToLogin = 'Back to Login';
  static const String resendCode = 'Resend Code';
  static const String verifyEmail = 'Verify Email';
  static const String verificationCodeSent = 'Verification code sent to your email';

  // ==================== Validation ====================
  static const String emailRequired = 'Email is required';
  static const String invalidEmail = 'Please enter a valid email address';
  static const String emailAlreadyExists = 'This email is already registered';
  static const String passwordRequired = 'Password is required';
  static const String passwordTooShort = 'Password must be at least 8 characters';
  static const String passwordMustContainUppercase = 'Password must contain at least one uppercase letter';
  static const String passwordMustContainLowercase = 'Password must contain at least one lowercase letter';
  static const String passwordMustContainNumber = 'Password must contain at least one number';
  static const String passwordMustContainSpecial = 'Password must contain at least one special character';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String confirmPasswordRequired = 'Please confirm your password';
  static const String nameRequired = 'Name is required';
  static const String nameTooShort = 'Name must be at least 2 characters';
  static const String phoneRequired = 'Phone number is required';
  static const String invalidPhone = 'Please enter a valid phone number';
  static const String urlRequired = 'URL is required';
  static const String invalidUrl = 'Please enter a valid URL';
  static const String fieldRequired = 'This field is required';

  // ==================== Errors ====================
  static const String networkError = 'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'An unknown error occurred.';
  static const String connectionTimeout = 'Connection timeout. Please try again.';
  static const String requestTimeout = 'Request timeout. Please try again.';
  static const String invalidCredentials = 'Invalid email or password.';
  static const String accountLocked = 'Your account has been locked. Please contact support.';
  static const String sessionExpired = 'Your session has expired. Please log in again.';
  static const String unauthorized = 'Unauthorized. Please log in again.';
  static const String forbidden = 'You do not have permission to access this resource.';
  static const String notFound = 'The requested resource was not found.';
  static const String somethingWentWrong = 'Something went wrong. Please try again.';

  // ==================== Navigation ====================
  static const String home = 'Home';
  static const String profile = 'Profile';
  static const String settings = 'Settings';
  static const String notifications = 'Notifications';
  static const String about = 'About';
  static const String help = 'Help';
  static const String termsOfService = 'Terms of Service';
  static const String privacyPolicy = 'Privacy Policy';
  static const String appVersion = 'App Version';

  // ==================== PubMate Features ====================
  static const String nearbyPubs = 'Nearby Pubs';
  static const String discoverPubs = 'Discover Pubs';
  static const String myFriends = 'My Friends';
  static const String events = 'Events';
  static const String map = 'Map';
  static const String search = 'Search';
  static const String filters = 'Filters';
  static const String venues = 'Venues';
  static const String venueDetails = 'Venue Details';
  static const String eventDetails = 'Event Details';
  static const String bookEvent = 'Book Event';
  static const String joinEvent = 'Join Event';
  static const String attendees = 'Attendees';
  static const String addFriend = 'Add Friend';
  static const String removeFriend = 'Remove Friend';
  static const String shareVenue = 'Share Venue';
  static const String location = 'Location';
  static const String distance = 'Distance';
  static const String rating = 'Rating';
  static const String reviews = 'Reviews';
  static const String leaveReview = 'Leave Review';
  static const String rewards = 'Rewards';
  static const String points = 'Points';
  static const String redeem = 'Redeem';
  static const String specialOffer = 'Special Offer';
  static const String noPubsNearby = 'No pubs found nearby';
  static const String enableLocation = 'Enable location to find pubs';
  static const String sortBy = 'Sort By';
  static const String filterBy = 'Filter By';
  static const String upcoming = 'Upcoming';
  static const String ongoing = 'Ongoing';
  static const String past = 'Past';

  // ==================== Messages ====================
  static const String noInternetConnection = 'No internet connection';
  static const String connectingToInternet = 'Connecting to internet...';
  static const String offlineMode = 'You are in offline mode';
  static const String noDataAvailable = 'No data available';
  static const String noNotifications = 'No notifications';
  static const String emptyState = 'Nothing here yet';
  static const String tryAgain = 'Try Again';
  static const String goBack = 'Go Back';
  static const String reportIssue = 'Report an Issue';

  // ==================== Dialogs ====================
  static const String confirmLogout = 'Are you sure you want to logout?';
  static const String confirmDelete = 'Are you sure you want to delete this?';
  static const String deleteCannotBeUndone = 'This action cannot be undone.';
  static const String areYouSure = 'Are you sure?';

  // ==================== Success Messages ====================
  static const String loginSuccessful = 'Login successful';
  static const String signupSuccessful = 'Account created successfully';
  static const String logoutSuccessful = 'Logout successful';
  static const String profileUpdated = 'Profile updated successfully';
  static const String settingsSaved = 'Settings saved successfully';
  static const String changesSaved = 'Changes saved successfully';
  static const String deletedSuccessfully = 'Deleted successfully';
}
