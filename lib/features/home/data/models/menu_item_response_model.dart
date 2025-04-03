import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item_response_model.freezed.dart';
part 'menu_item_response_model.g.dart';

/// A model class representing a menu item from the Wendy's API response.
///
/// This class encapsulates the core properties of a menu item including its
/// name, description, ID, and optional pricing and calorie information.
///
/// It leverages the [freezed] package to generate immutable data classes with
/// value equality and JSON serialization support.
@freezed
abstract class MenuItemResponseModel with _$MenuItemResponseModel {
  /// Creates a new instance of [MenuItemResponseModel].
  ///
  /// Required parameters:
  /// - [name]: The name of the menu item
  /// - [description]: A detailed description of the menu item
  /// - [menuItemId]: The unique identifier for the menu item
  ///
  /// Optional parameters:
  /// - [calorieRange]: The calorie information (e.g., "490 Cal")
  /// - [priceRange]: The price information (e.g., "$4.09" or "$0.99-$2.19")
  const factory MenuItemResponseModel({
    required String name,
    required String description,
    required int menuItemId,
    String? calorieRange,
    String? priceRange,
  }) = _MenuItemResponseModel;

  /// Creates a [MenuItemResponseModel] from a JSON map.
  ///
  /// This factory constructor is used for deserializing JSON data from the API.
  factory MenuItemResponseModel.fromJson(Map<String, Object?> json) =>
      _$MenuItemResponseModelFromJson(json);
}
