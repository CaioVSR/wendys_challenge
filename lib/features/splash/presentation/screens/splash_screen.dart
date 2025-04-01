import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wendys_challenge/features/home/home_navigator.dart';
import 'package:wendys_challenge/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:wendys_challenge/features/splash/presentation/widgets/animated_logo.dart';

/// A splash screen widget that displays the animated logo.
///
/// This widget listens to the [SplashCubit] state changes via a
/// [BlocListener]. When the state is `loadSuccess`, it can trigger a
/// navigation or any other side effect. The screen is a simple scaffold
/// that centers the animated logo within a padded layout.
class SplashScreen extends StatelessWidget {
  /// Creates an instance of [SplashScreen].
  ///
  /// The [key] parameter is used to uniquely identify the widget.
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        state.when(
          loadSuccess: () {
            context.goToHome();
          },
        );
      },
      child: const Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(child: AnimatedLogo()),
        ),
      ),
    );
  }
}
