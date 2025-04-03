import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wendys_challenge/core/widgets/exception_widget.dart';
import 'package:wendys_challenge/core/widgets/loading_widget.dart';
import 'package:wendys_challenge/features/home/home_navigator.dart';
import 'package:wendys_challenge/features/home/presentation/cubit/get_menus_cubit.dart';
import 'package:wendys_challenge/features/home/presentation/widgets/menu_tile.dart';

/// A screen that serves as the main interface for the application.
///
/// This screen is the entry point for the home feature and is
/// responsible for displaying the main content of the app.
class HomeScreen extends StatelessWidget {
  /// Creates a new instance of [HomeScreen].
  ///
  /// The [key] parameter uniquely identifies this widget.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<GetMenusCubit, GetMenusState>(
          builder: (context, state) {
            return state.when(
              orElse: () => const LoadingWidget(),
              loadFailure:
                  (failure) => ExceptionWidget(
                    errorMessage: failure.message,
                    retry: () => context.read<GetMenusCubit>().getMenus(),
                  ),
              loadSuccess: (menus) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final menu = menus[index];

                    return MenuTile(
                      text: menu.name,
                      onTap:
                          () => context.goToSubMenu(
                            SubMenuScreenParams(
                              menuName: menu.name,
                              menuItems: menu.menus,
                            ),
                          ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: menus.length,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
