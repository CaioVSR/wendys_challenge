import 'package:dartz/dartz.dart';

/// Defines a utility type for representing asynchronous operations
/// that can succeed or fail.
///
/// [Result<T>] is a type alias for a Future that resolves to an
/// Either containing either:
/// - An [Exception] on the left side (representing a failure)
/// - A value of type [T] on the right side (representing a success)
typedef Result<T> = Future<Either<Exception, T>>;

/// Creates a [Result] that represents a successful operation.
///
/// Wraps the given [value] in a [Right] and returns it as a [Result].
/// This is a convenience function for creating successful results.
Result<T> success<T>(T value) async => Right(value);

/// Creates a [Result] that represents a failed operation.
///
/// Wraps the given [exception] in a [Left] and returns it as a [Result].
/// If a string `message` is provided instead of an exception, it will be
/// wrapped in a generic Exception.
Result<T> failure<T>(dynamic exception) async {
  if (exception is Exception) {
    return Left(exception);
  }
  return Left(Exception(exception.toString()));
}

/// Extensions specifically for [Result] type to provide more
/// convenient async handling.
extension ResultX<T> on Result<T> {
  /// Awaits this [Result] and then handles the result.
  ///
  /// This combines awaiting and folding into a single call
  /// for more concise code.
  Future<void> fold({
    required void Function(Exception error) onFailure,
    required void Function(T data) onSuccess,
  }) async => (await this).fold(onFailure, onSuccess);
}
