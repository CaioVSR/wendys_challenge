import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wendys_challenge/core/entities/product_entity.dart';
import 'package:wendys_challenge/features/cart/presentation/cubit/cart_cubit.dart';

void main() {
  late CartCubit cartCubit;

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
    cartCubit = CartCubit();
  });

  group('CartCubit', () {
    test('initial state should be an empty list', () {
      expect(cartCubit.state, isA<List<ProductEntity>>());
      expect(cartCubit.state, isEmpty);
    });

    group('addToCart', () {
      blocTest<CartCubit, List<ProductEntity>>(
        'should add a product to an empty cart',
        build: () => cartCubit,
        act: (bloc) => bloc.addToCart(product1),
        expect:
            () => [
              [product1],
            ],
        verify: (bloc) {
          expect(bloc.state.length, 1);
          expect(bloc.state.first, equals(product1));
        },
      );

      blocTest<CartCubit, List<ProductEntity>>(
        'should add a second product to a non-empty cart',
        build: () => cartCubit..addToCart(product1),
        act: (bloc) => bloc.addToCart(product2),
        expect:
            () => [
              [product1, product2],
            ],
        verify: (bloc) {
          expect(bloc.state.length, 2);
          expect(bloc.state, contains(product1));
          expect(bloc.state, contains(product2));
        },
      );

      blocTest<CartCubit, List<ProductEntity>>(
        'should allow adding the same product multiple times',
        build: () => cartCubit,
        act: (bloc) {
          bloc
            ..addToCart(product1)
            ..addToCart(product1);
        },
        expect:
            () => [
              [product1],
              [product1, product1],
            ],
        verify: (bloc) {
          expect(bloc.state.length, 2);
          expect(bloc.state[0], equals(product1));
          expect(bloc.state[1], equals(product1));
        },
      );

      test('should create a new list instance for immutability', () {
        final originalState = cartCubit.state;

        cartCubit.addToCart(product1);
        final newState = cartCubit.state;

        expect(identical(originalState, newState), isFalse);
        expect(newState, isNot(same(originalState)));
      });
    });
  });
}
