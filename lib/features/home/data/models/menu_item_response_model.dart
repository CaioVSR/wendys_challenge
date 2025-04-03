import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item_response_model.freezed.dart';
part 'menu_item_response_model.g.dart';

@freezed
abstract class MenuItemResponseModel with _$MenuItemResponseModel {
  const factory MenuItemResponseModel({
    required String name,
    required String description,
    required int menuItemId,
    String? calorieRange,
    String? priceRange,
  }) = _MenuItemResponseModel;

  factory MenuItemResponseModel.fromJson(Map<String, Object?> json) =>
      _$MenuItemResponseModelFromJson(json);
}
