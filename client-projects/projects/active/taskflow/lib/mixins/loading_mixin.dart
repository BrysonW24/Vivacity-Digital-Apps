import 'package:flutter/foundation.dart';
import '../enums/loading_status.dart';

/// Loading Mixin
///
/// Provides common loading state management methods.
mixin LoadingMixin on ChangeNotifier {
  LoadingStatus _loadingStatus = LoadingStatus.initial;
  String? _errorMessage;

  LoadingStatus get loadingStatus => _loadingStatus;
  String? get errorMessage => _errorMessage;

  bool get isLoading =>
      _loadingStatus == LoadingStatus.loading ||
      _loadingStatus == LoadingStatus.loadingMore;

  bool get isRefreshing => _loadingStatus == LoadingStatus.refreshing;

  bool get hasError => _loadingStatus == LoadingStatus.error;

  bool get isEmpty => _loadingStatus == LoadingStatus.empty;

  bool get isSuccess => _loadingStatus == LoadingStatus.success;

  /// Set loading status
  void setLoadingStatus(LoadingStatus status) {
    _loadingStatus = status;
    notifyListeners();
  }

  /// Set error message
  void setError(String message) {
    _errorMessage = message;
    _loadingStatus = LoadingStatus.error;
    notifyListeners();
  }

  /// Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Set loading state
  void setLoading() {
    _loadingStatus = LoadingStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  /// Set success state
  void setSuccess() {
    _loadingStatus = LoadingStatus.success;
    _errorMessage = null;
    notifyListeners();
  }

  /// Set refreshing state
  void setRefreshing() {
    _loadingStatus = LoadingStatus.refreshing;
    _errorMessage = null;
    notifyListeners();
  }

  /// Set loading more state
  void setLoadingMore() {
    _loadingStatus = LoadingStatus.loadingMore;
    _errorMessage = null;
    notifyListeners();
  }

  /// Set empty state
  void setEmpty() {
    _loadingStatus = LoadingStatus.empty;
    _errorMessage = null;
    notifyListeners();
  }

  /// Reset to initial state
  void reset() {
    _loadingStatus = LoadingStatus.initial;
    _errorMessage = null;
    notifyListeners();
  }
}
