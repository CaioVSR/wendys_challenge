import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wendys_challenge/core/entities/product_entity.dart';
import 'package:wendys_challenge/core/extensions/cubit_extension.dart';

/// Cubit that manages the shopping cart state.
///
/// This cubit maintains a list of products added to the cart. The cart
/// starts empty, and products can be added using the [addToCart] method.
///
/// Uses [safeEmit] for safely emitting new states to avoid emitting after
/// the cubit is closed.
class CartCubit extends Cubit<List<ProductEntity>> {
  /// Creates a [CartCubit] instance with an empty cart.
  CartCubit() : super([]);

  /// Adds a [product] to the shopping cart.
  ///
  /// Creates a new list containing the current cart items plus the new product,
  /// then emits the updated state.
  void addToCart(ProductEntity product) {
    final updatedCart = List<ProductEntity>.from(state)..add(product);

    safeEmit(updatedCart);
  }
}
