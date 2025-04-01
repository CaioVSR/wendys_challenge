import 'package:freezed_annotation/freezed_annotation.dart';

part 'e_tag_model.freezed.dart';
part 'e_tag_model.g.dart';

/// A data model that represents a cached response with its associated
/// ETag.
///
/// This class is used by the `ETagInterceptor` to store HTTP responses
/// along with their ETag values for caching purposes. When a server returns
/// a 304 Not Modified response, the interceptor can retrieve the cached
/// payload using this model.
///
/// The class is implemented using the freezed package to provide
/// immutability, equality comparisons, and JSON serialization/
/// deserialization.
@freezed
abstract class ETagModel with _$ETagModel {
  /// Creates a new instance of [ETagModel].
  ///
  /// The [eTag] parameter is the ETag value returned by the server for the
  /// resource.
  /// The [payload] parameter is the response data to be cached and
  /// associated with the ETag.
  const factory ETagModel({
    required String eTag,
    required dynamic payload,
  }) = _ETagModel;

  /// Creates an [ETagModel] instance from a JSON map.
  ///
  /// This factory method is used when retrieving cached ETag data from
  /// storage. The generated code handles the deserialization of the payload.
  factory ETagModel.fromJson(Map<String, Object?> json) =>
      _$ETagModelFromJson(json);
}
