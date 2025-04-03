import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wendys_challenge/app/app_routes.dart';

/// Main application widget that wraps the app with necessary providers.
///
/// This widget serves as the root of the application and provides:
/// - Global loading overlay functionality for indicating loading states
/// - Router configuration for app navigation
class MainAppWidget extends StatelessWidget {
  /// Creates a main application widget.
  const MainAppWidget({super.key});

  @override
  /// Builds the application widget tree.
  ///
  /// Sets up the global loader overlay and configures the
  /// MaterialApp with routes.
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayWidgetBuilder:
          (progress) => LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.redAccent,
            size: 128,
          ),
      overlayColor: Colors.black.withValues(alpha: 0.6),
      child: MaterialApp.router(
        title: "Wendy's",
        routerConfig: AppRoutes.routerConfig,
        theme: ThemeData(
          primaryColor: Colors.redAccent,
          textTheme: GoogleFonts.poppinsTextTheme(),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
