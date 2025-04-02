import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wendys_challenge/features/home/data/models/sub_menu_response_model.dart';

part 'menu_lists_response_model.freezed.dart';
part 'menu_lists_response_model.g.dart';

/// A model class representing the response from a menu lists API.
/// 
/// This class encapsulates the data for a menu lists response. It leverages
/// the [freezed] package to generate immutable classes with value equality and
/// to provide JSON serialization/deserialization.
@freezed
abstract class MenuListsResponseModel with _$MenuListsResponseModel {
  /// Creates a new instance of [MenuListsResponseModel].
  ///
  /// The [subMenus] parameter is a list of submenu models included in the
  /// response.
  const factory MenuListsResponseModel({
    required List<SubMenuResponseModel> subMenus,
  }) = _MenuListsResponseModel;

  /// Creates an instance of [MenuListsResponseModel] from a JSON map.
  factory MenuListsResponseModel.fromJson(Map<String, Object?> json) =>
      _$MenuListsResponseModelFromJson(json);
}
