import 'package:flutter/material.dart';
import 'package:wendys_challenge/core/entities/product_entity.dart';
import 'package:wendys_challenge/features/home/home_navigator.dart';
import 'package:wendys_challenge/features/home/presentation/widgets/menu_tile.dart';

/// Parameters for configuring a [SubMenuScreen].
///
/// This class encapsulates the data needed to render a sub-menu screen,
/// including the menu items to display and the name of the menu category.
///
/// Used when navigating to a [SubMenuScreen] to provide all necessary
/// configuration data in a single, type-safe object.
class SubMenuScreenParams {
  /// Creates a new instance of [SubMenuScreenParams].
  ///
  /// [menuName] is the title of the menu category to display in the app bar.
  /// [products] is the list of menu items to display in this category.
  const SubMenuScreenParams({required this.menuName, required this.products});

  /// The list of menu items to display in this sub-menu.
  final List<ProductEntity> products;

  /// The name of the menu category, used as the screen title.
  final String menuName;
}

/// Screen that displays a list of menu items within a selected category.
///
/// This screen shows all items belonging to a specific menu category
/// (e.g., "Hamburgers" or "Sides"). Each menu item is displayed as a tappable
/// tile with its name.
///
/// The screen receives all configuration through a [SubMenuScreenParams]
/// object,
/// which provides the category name (used as the screen title) and the list of
/// menu items to display.
///
/// This screen is typically navigated to from the home screen when a user
/// selects a specific category from the main menu.
class SubMenuScreen extends StatelessWidget {
  /// Creates a [SubMenuScreen] with the provided configuration parameters.
  ///
  /// The [params] object contains the menu name and items to display.
  const SubMenuScreen({required this.params, super.key});

  /// Configuration parameters for this screen.
  final SubMenuScreenParams params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(params.menuName), centerTitle: true),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final product = params.products[index];

          return MenuTile(
            text: product.name,
            onTap:
                () =>
                    context.goToProduct(ProductScreenParams(product: product)),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: params.products.length,
      ),
    );
  }
}
