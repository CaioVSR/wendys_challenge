import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wendys_challenge/core/entities/product_entity.dart';
import 'package:wendys_challenge/features/cart/presentation/cubit/cart_cubit.dart';

/// Widget that displays a shopping bag icon with a counter badge.
///
/// This widget shows a red shopping bag icon with a small badge in the corner
/// displaying the current number of items in the cart. The badge is only shown
/// when the cart contains at least one item.
///
/// Uses [BlocBuilder] to automatically update whenever the cart contents 
/// change.
/// The widget reads the [CartCubit] from the widget tree to access the current
/// state of the shopping cart.
///
/// Example usage:
/// ```dart
/// AppBar(
///   actions: [
///     const CartIcon(),
///   ],
/// )
/// ```
class CartIcon extends StatelessWidget {
  /// Creates a [CartIcon] that displays the current cart item count.
  ///
  /// Relies on a [CartCubit] being available in the widget tree.
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, List<ProductEntity>>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                size: 30,
                color: Colors.redAccent,
              ),
              if (state.isNotEmpty)
                Positioned(
                  right: -6,
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      state.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
