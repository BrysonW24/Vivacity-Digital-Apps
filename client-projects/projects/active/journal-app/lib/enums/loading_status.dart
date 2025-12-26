/// Loading Status Enum
///
/// Represents different loading states for async operations.
enum LoadingStatus {
  initial,
  loading,
  success,
  error,
  refreshing,
  loadingMore,
  empty,
}

extension LoadingStatusExtension on LoadingStatus {
  /// Check if currently loading
  bool get isLoading =>
      this == LoadingStatus.loading || this == LoadingStatus.loadingMore;

  /// Check if data is available (success or empty state)
  bool get hasData =>
      this == LoadingStatus.success || this == LoadingStatus.empty;

  /// Check if state is error
  bool get isError => this == LoadingStatus.error;

  /// Check if state is success with data
  bool get isSuccess => this == LoadingStatus.success;

  /// Check if list is empty
  bool get isEmpty => this == LoadingStatus.empty;

  /// Check if currently refreshing data
  bool get isRefreshing => this == LoadingStatus.refreshing;

  /// Check if loading more data
  bool get isLoadingMore => this == LoadingStatus.loadingMore;

  /// Get display name for loading status
  String get displayName {
    switch (this) {
      case LoadingStatus.initial:
        return 'Initializing';
      case LoadingStatus.loading:
        return 'Loading...';
      case LoadingStatus.success:
        return 'Loaded';
      case LoadingStatus.error:
        return 'Error';
      case LoadingStatus.refreshing:
        return 'Refreshing...';
      case LoadingStatus.loadingMore:
        return 'Loading more...';
      case LoadingStatus.empty:
        return 'No data';
    }
  }
}
