import 'package:flutter/material.dart';

/// A reusable menu category tile widget with standard styling.
///
/// Renders a list tile with the provided [text] as title and a right-pointing
/// chevron icon. The entire tile is tappable and triggers [onTap] when pressed.
///
/// This widget provides consistent styling for menu items throughout the app,
/// with gray text and a red accent chevron.
///
/// Example usage:
/// ```dart
/// MenuTile(
///   text: 'Hamburgers',
///   onTap: () => Navigator.pushNamed(context, '/hamburgers'),
/// )
/// ```
class MenuTile extends StatelessWidget {
  /// Creates a [MenuTile] with the specified text and tap handler.
  ///
  /// The [text] parameter sets the displayed title text.
  /// The [onTap] callback is triggered when the user taps on the tile.
  const MenuTile({required this.text, required this.onTap, super.key});

  /// The text to display as the tile's title.
  final String text;

  /// Callback function that's invoked when the user taps the tile.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: Colors.grey.shade700),
        ),
        trailing: const Icon(
          Icons.chevron_right_outlined,
          size: 32,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
