import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:wendys_challenge/features/cart/cart_injections.dart';
import 'package:wendys_challenge/features/cart/presentation/cubit/cart_cubit.dart';

void main() {
  late CartInjections cartInjections;

  setUp(() async {
    GetIt.I.pushNewScope();

    cartInjections = CartInjections();

    await cartInjections.setUp();
  });

  tearDown(() {
    cartInjections.tearDown();
  });

  group('CartInjections', () {
    test('should have Cart as scope name', () {
      expect(cartInjections.scopeName, 'Cart');
    });

    test('should register CartCubit as a lazy singleton', () {
      final cartCubit1 = cartInjections.injector<CartCubit>();
      expect(cartCubit1, isA<CartCubit>());

      final cartCubit2 = cartInjections.injector<CartCubit>();
      expect(
        identical(cartCubit1, cartCubit2),
        isTrue,
        reason: 'Should return the same instance for multiple resolutions',
      );
    });

    test('should register CartCubit with an empty initial state', () {
      final cartCubit = cartInjections.injector<CartCubit>();
      expect(cartCubit.state, isEmpty);
    });

    test('should unregister dependencies on tearDown', () async {
      // First verify we can get the cubit
      cartInjections.injector<CartCubit>();

      // Tear down the injections
      await cartInjections.tearDown();

      // Now test that trying to resolve throws an exception
      expect(
        () => cartInjections.injector<CartCubit>(),
        throwsA(isA<StateError>()),
      );
    });

    test('should reset dependencies on setUp after tearDown', () async {
      final cartCubit1 = cartInjections.injector<CartCubit>();
      await cartInjections.tearDown();

      await cartInjections.setUp();

      final cartCubit2 = cartInjections.injector<CartCubit>();
      expect(cartCubit2, isA<CartCubit>());

      expect(identical(cartCubit1, cartCubit2), isFalse);
    });
  });
}
