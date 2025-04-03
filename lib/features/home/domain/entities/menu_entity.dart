import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_entity.freezed.dart';

@freezed
abstract class MenuEntity with _$MenuEntity {
  const factory MenuEntity({
    required int id,
    required String name,
    required String description,
    required int menuItemId,
    String? calorieRange,
    String? priceRange,
  }) = _MenuEntity;
}
