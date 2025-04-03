import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({required this.text, required this.onTap, super.key});

  final String text;
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
