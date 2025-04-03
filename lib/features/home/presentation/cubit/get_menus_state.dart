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
  bool get isInitial => this is _Initial;
  bool get isLoadInProgress => this is _LoadInProgress;
  bool get isLoadSuccess => this is _LoadSuccess;
  bool get isLoadFailure => this is _LoadFailure;

  /// Executes the corresponding callback for the current state.
  ///
  /// - [initial] is invoked when the state is [_Initial].
  /// - [loadInProgress] is invoked when the state is
  ///   [_LoadInProgress].
  /// - [loadSuccess] is invoked with the retrieved menus when the state is
  ///   [_LoadSuccess].
  /// - [loadFailure] is invoked with the exception when the state is
  ///   [_LoadFailure].
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
