import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wendys_challenge/features/home/domain/entities/menu_entity.dart';

part 'category_entity.freezed.dart';

@freezed
abstract class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    required String name,
    required List<MenuEntity> menus,
  }) = _CategoryEntity;
}
