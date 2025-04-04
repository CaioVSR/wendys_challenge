import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wendys_challenge/core/entities/product_entity.dart';
import 'package:wendys_challenge/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:wendys_challenge/features/cart/presentation/widgets/cart_icon.dart';

class MockCartCubit extends MockCubit<List<ProductEntity>>
    implements CartCubit {}

void main() {
  late MockCartCubit mockCartCubit;

  const product1 = ProductEntity(
    id: 1,
    name: "Dave's Single",
    description: 'A quarter-pound of fresh beef',
    menuItemId: 101,
    calorieRange: '570 Cal',
    priceRange: r'$4.99',
  );

  const product2 = ProductEntity(
    id: 2,
    name: 'Fries',
    description: 'Natural-cut, sea-salted fries',
    menuItemId: 201,
    calorieRange: '350 Cal',
    priceRange: r'$2.19',
  );

  setUp(() {
    mockCartCubit = MockCartCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            BlocProvider<CartCubit>.value(
              value: mockCartCubit,
              child: const CartIcon(),
            ),
          ],
        ),
      ),
    );
  }

  group('CartIcon', () {
    testWidgets('should display shopping bag icon', (tester) async {
      when(() => mockCartCubit.state).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('should not display badge when cart is empty', (tester) async {
      when(() => mockCartCubit.state).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('0'), findsNothing);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('should display badge with count 1 for one item', (
      tester,
    ) async {
      when(() => mockCartCubit.state).thenReturn([product1]);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('1'), findsOneWidget);
      expect(find.byType(Positioned), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should display badge with count 2 for two items', (
      tester,
    ) async {
      when(() => mockCartCubit.state).thenReturn([product1, product2]);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('should have red accent color for icon and badge', (
      tester,
    ) async {
      when(() => mockCartCubit.state).thenReturn([product1]);

      await tester.pumpWidget(createWidgetUnderTest());

      final iconFinder = find.byType(Icon);
      expect(iconFinder, findsOneWidget);
      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.color, Colors.redAccent);

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsWidgets);
      final container = tester.widget<Container>(containerFinder.last);
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, Colors.redAccent);
    });
  });
}
