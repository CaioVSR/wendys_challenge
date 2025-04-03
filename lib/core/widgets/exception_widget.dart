import 'package:flutter/material.dart';

/// A reusable widget for displaying error states with a retry option.
///
/// The [ExceptionWidget] provides a standardized way to present 
/// error states to users throughout the application. It displays an error 
/// message and a "Try Again" button that triggers a callback when pressed.
///
/// This widget is designed to be used within screens that might encounter 
/// errors during data loading or processing operations. It follows a 
/// consistent layout:
/// - Error message centered in the available space
/// - "Try Again" button positioned below the message
///
/// Example usage:
/// ```dart
/// if (state.isError) {
///   return ExceptionWidget(
///     errorMessage: 'Failed to load menu items',
///     retry: () => cubit.loadData(),
///   );
/// }
/// ```
class ExceptionWidget extends StatelessWidget {
  /// Creates an [ExceptionWidget] with the specified error message and 
  /// retry callback.
  ///
  /// The [errorMessage] parameter is a user-friendly description of what 
  /// went wrong.
  /// The [retry] callback will be executed when the user taps the "Try Again" 
  /// button.
  const ExceptionWidget({
    required this.errorMessage,
    required this.retry,
    super.key,
  });

  /// The error message to display to the user.
  ///
  /// This should be a user-friendly message that describes what went wrong
  /// in language the user can understand.
  final String errorMessage;

  /// Callback function that is executed when the user taps the "Try Again" 
  /// button.
  ///
  /// This should typically trigger a reload or retry of the failed operation.
  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Text(errorMessage, style: Theme.of(context).textTheme.bodyLarge),
        const Spacer(),
        ElevatedButton(onPressed: retry, child: const Text('Try Again')),
      ],
    );
  }
}
