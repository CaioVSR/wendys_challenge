import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wendys_challenge/core/widgets/exception_widget.dart';

void main() {
  group('ExceptionWidget', () {
    const errorMessage = 'Test error message';

    testWidgets('displays the provided error message', (
      WidgetTester tester,
    ) async {
      final widget = MaterialApp(
        home: Scaffold(
          body: ExceptionWidget(errorMessage: errorMessage, retry: () {}),
        ),
      );

      await tester.pumpWidget(widget);

      expect(
        find.text(errorMessage),
        findsOneWidget,
        reason: 'The widget should display the error message.',
      );
    });

    testWidgets('displays the "Try Again" button', (WidgetTester tester) async {
      final widget = MaterialApp(
        home: Scaffold(
          body: ExceptionWidget(errorMessage: errorMessage, retry: () {}),
        ),
      );

      await tester.pumpWidget(widget);

      expect(
        find.widgetWithText(ElevatedButton, 'Try Again'),
        findsOneWidget,
        reason: 'The widget should display the "Try Again" button.',
      );
    });

    testWidgets(
      'triggers the retry callback when the "Try Again" button is pressed',
      (WidgetTester tester) async {
        var retryCalled = false;
        final widget = MaterialApp(
          home: Scaffold(
            body: ExceptionWidget(
              errorMessage: errorMessage,
              retry: () {
                retryCalled = true;
              },
            ),
          ),
        );

        await tester.pumpWidget(widget);
        await tester.tap(find.widgetWithText(ElevatedButton, 'Try Again'));
        await tester.pump();

        expect(
          retryCalled,
          isTrue,
          reason:
              'The retry callback should be called when the button is pressed.',
        );
      },
    );
  });
}
