part of 'splash_cubit.dart';

/// A union type representing the state of the splash screen.
///
/// The [SplashState] defines the possible states for the splash screen:
/// - `initial`: The splash screen is in its initial state.
/// - `loadInProgress`: The splash screen is currently loading.
/// - `loadSuccess`: The splash screen has loaded successfully.
/// - `error`: An error occurred during the loading process.
@freezed
sealed class SplashState with _$SplashState {
  const factory SplashState.initial() = _Initial;
  const factory SplashState.loadInProgress() = _LoadInProgress;
  const factory SplashState.loadSuccess() = _LoadSuccess;
  const factory SplashState.loadFailure(String message) = _LoadFailure;
}

/// Extension methods for [SplashState] to simplify state-based logic.
///
/// The [when] method allows handling each state via callbacks.
extension SplashStateX on SplashState {
  /// Executes the corresponding callback for the current state.
  ///
  /// [loadSuccess] is required and will be called if the state is
  /// [loadSuccess]. Optional callbacks [initial], [loadInProgress]
  /// and [loadFailure]can be provided for the other states.
  void when({
    required VoidCallback loadSuccess,
    VoidCallback? initial,
    VoidCallback? loadInProgress,
    VoidCallback? loadFailure,
  }) => switch (this) {
    _Initial _ => initial?.call(),
    _LoadInProgress _ => loadInProgress?.call(),
    _LoadSuccess _ => loadSuccess.call(),
    _LoadFailure _ => loadFailure?.call(),
  };
}
