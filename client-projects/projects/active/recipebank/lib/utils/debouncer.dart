import 'dart:async';

/// Debouncer
///
/// Delays execution of a function until after a specified duration.
/// Useful for search inputs, resizing, etc.
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  /// Execute function with debounce
  void call(Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  /// Cancel pending execution
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Dispose debouncer
  void dispose() {
    cancel();
  }
}

/// Throttler
///
/// Executes a function at most once per specified duration.
/// Useful for scroll events, button clicks, etc.
class Throttler {
  final Duration duration;
  DateTime? _lastExecutionTime;
  Timer? _timer;

  Throttler({this.duration = const Duration(milliseconds: 300)});

  /// Execute function with throttle
  void call(Function() callback) {
    final now = DateTime.now();

    if (_lastExecutionTime == null ||
        now.difference(_lastExecutionTime!).compareTo(duration) >= 0) {
      _lastExecutionTime = now;
      callback();
    } else {
      _timer?.cancel();
      final remaining =
          duration.inMilliseconds - now.difference(_lastExecutionTime!).inMilliseconds;
      _timer = Timer(Duration(milliseconds: remaining), () {
        _lastExecutionTime = DateTime.now();
        callback();
      });
    }
  }

  /// Reset throttler
  void reset() {
    _lastExecutionTime = null;
    _timer?.cancel();
    _timer = null;
  }

  /// Dispose throttler
  void dispose() {
    reset();
  }
}
