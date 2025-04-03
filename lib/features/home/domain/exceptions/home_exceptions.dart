import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wendys_challenge/core/base/base_exception.dart';

part 'home_exceptions.freezed.dart';

/// A sealed class representing errors in the home feature.
///
/// This class uses the [freezed] package to define a union of exception types
/// for the home feature. It implements [Exception] to facilitate
/// error handling.
///
/// Currently, it defines a `generic` error which can be used to represent an
/// unexpected error with an optional [message].
@freezed
sealed class HomeExceptions extends Failure with _$HomeExceptions {
  const HomeExceptions._(super.message);

  /// Creates a generic exception with an optional [message].
  ///
  /// The [message] parameter defaults to "Sorry, something went wrong" if not
  /// provided.
  const factory HomeExceptions.generic([
    @Default('Sorry, something went wrong') String message,
  ]) = _Generic;
}
