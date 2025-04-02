import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_menu_response_model.freezed.dart';
part 'sub_menu_response_model.g.dart';

/// A model class representing the response from a submenu API.
///
/// This class encapsulates the data for a submenu response. It leverages
/// the [freezed] package to generate immutable classes with value equality and
/// to provide JSON serialization/deserialization.
@freezed
abstract class SubMenuResponseModel with _$SubMenuResponseModel {
  /// Creates a new instance of [SubMenuResponseModel].
  ///
  /// - [productGroupId] is an optional string representing
  ///   the product group ID.
  /// - [name] is a string representing the name of the submenu.
  /// - [description] is a string representing the description of the submenu.
  /// - [displayName] is a string representing the display name of the submenu.
  /// - [baseImageName] is a string representing the base image name of
  /// the submenu.
  /// - [subMenuId] is an integer representing the submenu ID.
  /// - [menuItems] is a list of integers representing the menu items
  /// associated with the submenu.
  /// - [attributes] is a map of string keys to dynamic values representing
  /// additional attributes of the submenu.
  /// - [titleTag] is an optional string representing the title tag of
  /// the submenu.
  /// - [metaDescription] is an optional string representing the meta
  /// description of the submenu.
  /// - [disclaimerCode] is an optional string representing the disclaimer
  /// code of the submenu.
  const factory SubMenuResponseModel({
    required String name,
    required String description,
    required String displayName,
    required String baseImageName,
    required int subMenuId,
    required List<int> menuItems,
    required Map<String, dynamic> attributes,
    String? productGroupId,
    String? titleTag,
    String? metaDescription,
    String? disclaimerCode,
  }) = _SubMenuResponseModel;

  /// Creates an instance of [SubMenuResponseModel] from a JSON map.
  factory SubMenuResponseModel.fromJson(Map<String, Object?> json) =>
      _$SubMenuResponseModelFromJson(json);
}
