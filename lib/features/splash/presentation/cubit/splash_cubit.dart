import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wendys_challenge/core/extensions/cubit_extension.dart';

part 'splash_state.dart';
part 'splash_cubit.freezed.dart';

/// A Cubit that manages the state of the splash screen.
///
/// The [SplashCubit] simulates an initialization process by first
/// emitting a loadInProgress state, then after a delay, emitting a
/// loadSuccess state.
class SplashCubit extends Cubit<SplashState> {
  /// Creates a new instance of [SplashCubit].
  ///
  /// The initial state is set to [SplashState.initial].
  SplashCubit() : super(const SplashState.initial());

  /// Initializes the splash screen.
  ///
  /// This method simulates some initialization work by first emitting a
  /// [SplashState.loadInProgress] state. After a 2-second delay, it emits a
  /// [SplashState.loadSuccess] state.
  void initialize() {
    safeEmit(const SplashState.loadInProgress());

    // Simulate some initialization work

    Future.delayed(const Duration(seconds: 2), () {
      safeEmit(const SplashState.loadSuccess());
    });
  }
}
