import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wendys_challenge/core/extensions/cubit_extension.dart';
import 'package:wendys_challenge/features/home/domain/entities/category_entity.dart';
import 'package:wendys_challenge/features/home/domain/exceptions/home_exceptions.dart';
import 'package:wendys_challenge/features/home/domain/use_cases/get_home_menus_use_case.dart';

part 'get_menus_state.dart';
part 'get_menus_cubit.freezed.dart';

class GetMenusCubit extends Cubit<GetMenusState> {
  GetMenusCubit(this._getHomeMenuUseCase)
    : super(const GetMenusState.initial());

  final GetHomeMenuUseCase _getHomeMenuUseCase;

  Future<void> getMenus() async {
    safeEmit(const GetMenusState.loadInProgress());

    final result = await _getHomeMenuUseCase.execute();

    result.fold(
      (failure) => safeEmit(GetMenusState.loadFailure(failure)),
      (data) => safeEmit(GetMenusState.loadSuccess(data)),
    );
  }
}
