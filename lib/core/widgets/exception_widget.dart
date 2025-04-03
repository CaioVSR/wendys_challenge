import 'package:flutter/material.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({
    required this.errorMessage,
    required this.retry,
    super.key,
  });

  final String errorMessage;
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
