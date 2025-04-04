import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wendys_challenge/core/utils/injection_scope_wrapper.dart';

InjectionScopeWrapper createTestWidget({
  required VoidCallback onSetUp,
  required VoidCallback onTearDown,
  required Widget child,
}) {
  return InjectionScopeWrapper(
    setUp: onSetUp,
    tearDown: onTearDown,
    child: child,
  );
}

void main() {
  group('InjectionScopeWrapper', () {
    testWidgets('calls setUp on initState', (WidgetTester tester) async {
      var setUpCalled = false;
      final testWidget = createTestWidget(
        onSetUp: () {
          setUpCalled = true;
        },
        onTearDown: () {},
        child: const SizedBox(),
      );

      await tester.pumpWidget(MaterialApp(home: testWidget));

      expect(
        setUpCalled,
        isTrue,
        reason:
            'setUp should be called when the widget is inserted into the tree.',
      );
    });

    testWidgets('calls tearDown on dispose', (WidgetTester tester) async {
      var tearDownCalled = false;
      final testWidget = createTestWidget(
        onSetUp: () {},
        onTearDown: () {
          tearDownCalled = true;
        },
        child: const SizedBox(),
      );

      await tester.pumpWidget(MaterialApp(home: testWidget));
      await tester.pumpWidget(const MaterialApp(home: Placeholder()));
      await tester.pumpAndSettle();

      expect(
        tearDownCalled,
        isTrue,
        reason:
            'tearDown should be called when the widget is removed from the tree.',
      );
    });

    testWidgets('renders the child widget correctly', (
      WidgetTester tester,
    ) async {
      const childKey = Key('child');
      const childText = 'Hello, Injection!';
      final testWidget = createTestWidget(
        onSetUp: () {},
        onTearDown: () {},
        child: const Text(childText, key: childKey),
      );

      await tester.pumpWidget(MaterialApp(home: testWidget));

      expect(
        find.byKey(childKey),
        findsOneWidget,
        reason: 'Child widget with the expected key should be rendered.',
      );
      expect(
        find.text(childText),
        findsOneWidget,
        reason: 'Child widget text should be visible.',
      );
    });

    testWidgets('maintains child state across interactions', (
      WidgetTester tester,
    ) async {
      var counter = 0;
      final statefulChild = StatefulBuilder(
        builder: (
          BuildContext context,
          void Function(void Function()) setState,
        ) {
          return TextButton(
            onPressed: () {
              setState(() {
                counter++;
              });
            },
            child: Text('Counter: $counter'),
          );
        },
      );
      final testWidget = createTestWidget(
        onSetUp: () {},
        onTearDown: () {},
        child: statefulChild,
      );

      await tester.pumpWidget(MaterialApp(home: testWidget));

      expect(
        find.text('Counter: 0'),
        findsOneWidget,
        reason: 'Initial counter should be 0.',
      );

      await tester.tap(find.byType(TextButton));
      await tester.pump();

      expect(
        find.text('Counter: 1'),
        findsOneWidget,
        reason: 'The counter should increment after tap.',
      );
    });

    testWidgets('does not call setUp again on widget rebuild without removal', (
      WidgetTester tester,
    ) async {
      var setUpCallCount = 0;
      final testWidget = createTestWidget(
        onSetUp: () {
          setUpCallCount++;
        },
        onTearDown: () {},
        child: const SizedBox(),
      );

      await tester.pumpWidget(MaterialApp(home: testWidget));

      await tester.pump();

      expect(
        setUpCallCount,
        equals(1),
        reason: 'setUp should not be called again on rebuilds without removal.',
      );
    });

    testWidgets('calls setUp again when reinserting the widget after removal', (
      WidgetTester tester,
    ) async {
      var setUpCallCount = 0;
      var tearDownCallCount = 0;
      final testWidget = createTestWidget(
        onSetUp: () {
          setUpCallCount++;
        },
        onTearDown: () {
          tearDownCallCount++;
        },
        child: const SizedBox(),
      );

      await tester.pumpWidget(MaterialApp(home: testWidget));
      expect(setUpCallCount, equals(1));

      await tester.pumpWidget(const MaterialApp(home: Placeholder()));
      await tester.pumpAndSettle();
      expect(tearDownCallCount, equals(1));

      await tester.pumpWidget(MaterialApp(home: testWidget));
      await tester.pump();

      expect(
        setUpCallCount,
        equals(2),
        reason: 'setUp should be called again when the widget is reinserted.',
      );
    });
  });
}
