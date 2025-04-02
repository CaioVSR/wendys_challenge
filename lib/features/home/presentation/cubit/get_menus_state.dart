part of 'get_menus_cubit.dart';

/// A union type representing the state of the home menu retrieval process.
///
/// The [GetMenusState] class defines the different states of fetching menu
/// data. It leverages the [freezed] package to create immutable, sealed
/// classes with value equality and utility methods.
@freezed
sealed class GetMenusState with _$GetMenusState {
  /// The initial state of the menu retrieval process.
  const factory GetMenusState.initial() = _Initial;

  /// Indicates that the menu retrieval is in progress.
  const factory GetMenusState.loadInProgress() = _LoadInProgress;

  /// Indicates that the menu retrieval succeeded.
  ///
  /// The [menus] parameter contains the list of retrieved categories.
  const factory GetMenusState.loadSuccess(List<CategoryEntity> menus) =
      _LoadSuccess;

  /// Indicates that the menu retrieval failed.
  ///
  /// The [exception] parameter contains details about the error.
  const factory GetMenusState.loadFailure(HomeExceptions exception) =
      _LoadFailure;
}

/// Extension on [GetMenusState] that provides a convenient `when` method.
///
/// The [when] method executes a callback based on the current state, thus
/// eliminating the need for explicit type checks or switch-case constructs.
extension GetMenusStateX on GetMenusState {
  /// Executes the corresponding callback for the current state.
  ///
  /// - [initial] is invoked when the state is [_Initial].
  /// - [loadInProgress] is invoked when the state is
  ///   [_LoadInProgress].
  /// - [loadSuccess] is invoked with the retrieved menus when the state is
  ///   [_LoadSuccess].
  /// - [loadFailure] is invoked with the exception when the state is
  ///   [_LoadFailure].
  void when({
    required VoidCallback? initial,
    required VoidCallback loadInProgress,
    required void Function(List<CategoryEntity> menus) loadSuccess,
    required void Function(HomeExceptions exception) loadFailure,
  }) {
    return switch (this) {
      _Initial _ => initial?.call(),
      _LoadInProgress _ => loadInProgress(),
      final _LoadSuccess state => loadSuccess(state.menus),
      final _LoadFailure state => loadFailure(state.exception),
    };
  }
}
