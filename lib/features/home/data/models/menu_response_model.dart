import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wendys_challenge/features/home/data/models/menu_lists_response_model.dart';

part 'menu_response_model.freezed.dart';
part 'menu_response_model.g.dart';

/// A model class representing the response from a menu API.
/// 
/// This class encapsulates the data for a menu lists response. It leverages
/// the [freezed] package to generate immutable classes with value equality and
/// to provide JSON serialization/deserialization.
@freezed
abstract class MenuResponseModel with _$MenuResponseModel {
  /// Creates a new instance of [MenuResponseModel].
  /// 
  /// The [serviceStatus] parameter indicates the status of the service
  /// response. The [menuLists] parameter is an 
  /// instance of [MenuListsResponseModel] that contains the list of menus.
  const factory MenuResponseModel({
    required String serviceStatus,
    required MenuListsResponseModel menuLists,
  }) = _MenuResponseModel;

  /// Creates an instance of [MenuResponseModel] from a JSON map.
  factory MenuResponseModel.fromJson(Map<String, Object?> json) =>
      _$MenuResponseModelFromJson(json);
}
