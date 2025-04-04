import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wendys_challenge/core/entities/product_entity.dart';
import 'package:wendys_challenge/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:wendys_challenge/features/home/home_navigator.dart';

/// Parameters for configuring a [ProductScreen].
///
/// This class encapsulates the data needed to display detailed information
/// about a specific menu item.
///
/// Used when navigating to a [ProductScreen] to provide the product
/// information in a single, type-safe object.
class ProductScreenParams {
  /// Creates a new instance of [ProductScreenParams].
  ///
  /// [product] is the menu item to display details for.
  const ProductScreenParams({required this.product});

  /// The menu item to display details for.
  final ProductEntity product;
}

/// Screen that displays detailed information about a specific menu item.
///
/// This screen shows comprehensive information about a selected menu item,
/// including:
/// - Item description
/// - Calorie information (when available)
/// - Price information (when available)
///
/// The screen also includes a floating action button to add the item to
/// the user's order.
///
/// This screen is typically navigated to when a user taps on a specific menu
/// item in a sub-menu list.
class ProductScreen extends StatelessWidget {
  /// Creates a [ProductScreen] with the provided configuration parameters.
  ///
  /// The [params] object contains the product information to display.
  const ProductScreen({required this.params, super.key});

  /// Configuration parameters for this screen.
  final ProductScreenParams params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(params.product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 32,
          children: [
            Text(
              params.product.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Calories: ${params.product.calorieRange ?? 'Not available'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Price: ${params.product.priceRange ?? 'Not available'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<CartCubit>().addToCart(params.product);
          context.goToHome();
        },
      ),
    );
  }
}
