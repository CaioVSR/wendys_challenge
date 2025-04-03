import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wendys_challenge/features/home/presentation/screens/product_screen.dart';
import 'package:wendys_challenge/features/home/presentation/screens/sub_menu_screen.dart';

export 'package:wendys_challenge/features/home/presentation/screens/product_screen.dart'
    show ProductScreenParams;
export 'package:wendys_challenge/features/home/presentation/screens/sub_menu_screen.dart'
    show SubMenuScreenParams;

/// Extension on [BuildContext] that provides convenient navigation methods.
///
/// This extension simplifies route management by exposing helper methods to
/// navigate between screens using named routes with the [GoRouter] package.
extension HomeNavigator on BuildContext {
  /// Navigates to the home screen
  void goToHome() => goNamed('home');

  /// Navigates to the sub-menu screen with the provided parameters.
  void goToSubMenu(SubMenuScreenParams params) =>
      pushNamed('sub-menu', extra: params);

  /// Navigates to the product screen with the provided parameters.
  void goToProduct(ProductScreenParams params) =>
      pushNamed('product', extra: params);
}
