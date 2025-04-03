part of 'get_menus_cubit.dart';

/// A union type representing the state of the home menu retrieval process.
///
/// Defines the lifecycle states of menu data fetching:
///  - initial: Before any fetch attempt
///  - loadInProgress: During active fetch operation
///  - loadSuccess: When menu data is successfully retrieved
///  - loadFailure: When an error occurs during retrieval
@freezed
sealed class GetMenusState with _$GetMenusState {
  /// Initial state before any menu fetch operation has started.
  const factory GetMenusState.initial() = _Initial;

  /// State indicating an ongoing menu fetch operation.
  const factory GetMenusState.loadInProgress() = _LoadInProgress;

  /// State indicating a successful menu fetch operation.
  ///
  /// Contains the retrieved [menus] list for display in the UI.
  const factory GetMenusState.loadSuccess(List<CategoryEntity> menus) =
      _LoadSuccess;

  /// State indicating a failed menu fetch operation.
  ///
  /// Contains the [exception] that caused the failure.
  const factory GetMenusState.loadFailure(HomeExceptions exception) =
      _LoadFailure;
}

/// Extension providing helper methods for working with [GetMenusState].
extension GetMenusStateX on GetMenusState {
  /// Executes the corresponding callback for the current state.
  ///
  /// Provides a typesafe way to handle different states:
  ///  - [initial]: Called for initial state
  ///  - [loadInProgress]: Called while loading
  ///  - [loadSuccess]: Called with menu data on success
  ///  - [loadFailure]: Called with exception on failure
  ///  - [orElse]: Default handler for any unhandled state
  T when<T>({
    required T Function() orElse,
    T Function()? initial,
    T Function()? loadInProgress,
    T Function(List<CategoryEntity> menus)? loadSuccess,
    T Function(HomeExceptions exception)? loadFailure,
  }) {
    return switch (this) {
      _Initial _ => initial != null ? initial() : orElse(),
      _LoadInProgress _ => loadInProgress != null ? loadInProgress() : orElse(),
      final _LoadSuccess state =>
        loadSuccess != null ? loadSuccess(state.menus) : orElse(),
      final _LoadFailure state =>
        loadFailure != null ? loadFailure(state.exception) : orElse(),
    };
  }
}
