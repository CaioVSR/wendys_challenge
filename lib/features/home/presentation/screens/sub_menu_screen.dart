import 'package:flutter/material.dart';
import 'package:wendys_challenge/features/home/domain/entities/menu_entity.dart';
import 'package:wendys_challenge/features/home/presentation/widgets/menu_tile.dart';

class SubMenuScreenParams {
  const SubMenuScreenParams({required this.menuName, required this.menuItems});

  final List<MenuEntity> menuItems;
  final String menuName;
}

class SubMenuScreen extends StatelessWidget {
  const SubMenuScreen({required this.params, super.key});

  final SubMenuScreenParams params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(params.menuName), centerTitle: true),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final menu = params.menuItems[index];

          return MenuTile(text: menu.name, onTap: () {});
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: params.menuItems.length,
      ),
    );
  }
}
