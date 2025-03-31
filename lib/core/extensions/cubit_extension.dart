import 'package:flutter_bloc/flutter_bloc.dart';

/// Extension on [Cubit] to provide safe state emission capabilities.
///
/// This extension helps prevent common errors when emitting states to a cubit
/// that might have been closed, which typically results in runtime exceptions.
extension CubitExtension<T> on Cubit<T> {
  /// Safely emits a new state only if the cubit is not closed.
  ///
  /// This method prevents "emit after close" exceptions by checking the cubit's
  /// closed status before attempting to emit a new state.
  ///
  /// Example:
  /// ```dart
  /// cubit.safeEmit(newState); // Won't throw if cubit is closed
  /// ```
  ///
  /// [state] The new state to emit if the cubit is still active.
  void safeEmit(T state) {
    if (!isClosed) {
      /// The following diagnostics are ignored because this extension
      /// needs to access the 'isClosed' property of Cubit which is either
      /// protected or marked as visible for testing only. This access is
      /// necessary for the safe emission functionality to work properly.
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      emit(state);
    }
  }
}
