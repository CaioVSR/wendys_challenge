/// Abstract base class for all application-specific exceptions.
///
/// [BaseException] serves as the foundation for the application's error
/// handling hierarchy. It implements the standard Dart [Exception] interface
/// while providing a consistent structure for all derived exceptions.
///
/// This class establishes a pattern where all exceptions in the application:
/// 1. Contain a human-readable error message
/// 2. Share a common ancestor for consistent error handling
/// 3. Can be easily identified as application-specific exceptions
///
/// Application layers should define their own exception types that extend
/// this class rather than using generic exceptions.
abstract class BaseException implements Exception {
  /// Creates a new [BaseException] with the provided error message.
  ///
  /// @param message A human-readable description of what went wrong.
  const BaseException(this.message);

  /// A descriptive message explaining the nature of the exception.
  final String message;
}

/// Represents a business logic or domain rule violation.
///
/// While [BaseException] is typically used for unexpected errors or
/// technical issues, [Failure] represents expected but invalid conditions
/// within the business domain. For example:
/// - Validation errors
/// - Business rule violations
/// - Expected error conditions
///
/// This distinction helps separate technical exceptions from domain-specific
/// error conditions in the application architecture.
abstract class Failure extends BaseException {
  /// Creates a new [Failure] with the provided error message.
  ///
  /// @param message A human-readable description of the failure condition.
  const Failure(super.message);
}
