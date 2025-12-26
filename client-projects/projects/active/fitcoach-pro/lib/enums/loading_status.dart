/// Loading state enumeration
enum LoadingStatus {
  initial,
  loading,
  success,
  error,
  refreshing,
  loadingMore,
  empty,
}

extension LoadingStatusX on LoadingStatus {
  bool get isInitial => this == LoadingStatus.initial;
  bool get isLoading => this == LoadingStatus.loading;
  bool get isSuccess => this == LoadingStatus.success;
  bool get isError => this == LoadingStatus.error;
  bool get isRefreshing => this == LoadingStatus.refreshing;
  bool get isLoadingMore => this == LoadingStatus.loadingMore;
  bool get isEmpty => this == LoadingStatus.empty;
  bool get isAnyLoading => isLoading || isRefreshing || isLoadingMore;
  bool get canShowData => isSuccess || isRefreshing || isLoadingMore;

  String get message {
    switch (this) {
      case LoadingStatus.initial:
        return 'Ready';
      case LoadingStatus.loading:
        return 'Loading...';
      case LoadingStatus.success:
        return 'Success';
      case LoadingStatus.error:
        return 'Error occurred';
      case LoadingStatus.refreshing:
        return 'Refreshing...';
      case LoadingStatus.loadingMore:
        return 'Loading more...';
      case LoadingStatus.empty:
        return 'No data available';
    }
  }
}
