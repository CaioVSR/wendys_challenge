import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wendys_challenge/core/extensions/cubit_extension.dart';
import 'package:wendys_challenge/features/home/domain/entities/category_entity.dart';
import 'package:wendys_challenge/features/home/domain/exceptions/home_exceptions.dart';
import 'package:wendys_challenge/features/home/domain/use_cases/get_home_menus_use_case.dart';

part 'get_menus_state.dart';
part 'get_menus_cubit.freezed.dart';

/// Manages the state for fetching menu categories in the home feature.
///
/// This cubit handles the process of retrieving menu categories data from
/// the domain layer through [GetHomeMenuUseCase] and transforms the result
/// into appropriate [GetMenusState] instances.
///
/// The state transitions follow this flow:
///   1. [GetMenusState.initial] - Initial state before any action
///   2. [GetMenusState.loadInProgress] - Shown while fetching data
///   3. [GetMenusState.loadSuccess] - When categories are successfully loaded
///   4. [GetMenusState.loadFailure] - When an error occurs during loading
///
/// The cubit uses [safeEmit] extension to ensure that state emissions happen
/// only when the cubit is active and hasn't been closed.
class GetMenusCubit extends Cubit<GetMenusState> {
  /// Creates a [GetMenusCubit] with the required use case dependency.
  ///
  /// Initializes with the [GetMenusState.initial] state.
  GetMenusCubit(this._getHomeMenuUseCase)
    : super(const GetMenusState.initial());

  /// The use case responsible for retrieving menu categories.
  final GetHomeMenuUseCase _getHomeMenuUseCase;

  /// Triggers the process of fetching menu categories.
  ///
  /// Emits appropriate states based on the operation result:
  ///   - `loadInProgress` while the data is being fetched
  ///   - `loadSuccess` with the categories when fetching succeeds
  ///   - `loadFailure` with the error when fetching fails
  Future<void> getMenus() async {
    safeEmit(const GetMenusState.loadInProgress());

    final result = await _getHomeMenuUseCase.execute();

    result.fold(
      (failure) => safeEmit(GetMenusState.loadFailure(failure)),
      (data) => safeEmit(GetMenusState.loadSuccess(data)),
    );
  }
}
