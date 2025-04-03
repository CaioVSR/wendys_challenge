import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:wendys_challenge/core/services/http_service/http_service.dart';
import 'package:wendys_challenge/features/home/data/models/menu_response_model.dart';

/// A data source interface for fetching home menu data.
///
/// This interface defines the contract for a data source that retrieves
/// home menu data. It provides a method to fetch the menu data and handle
/// the result.
sealed class HomeDataSource {
  /// Fetches the home menu data.
  Future<Either<Exception, MenuResponseModel>> getHomeMenu();
}

/// Implementation of [HomeDataSource] that uses an HTTP service to fetch
/// home menu data.
class HomeDataSourceImpl implements HomeDataSource {
  /// Creates a new instance of [HomeDataSourceImpl].
  ///
  /// The constructor takes an [HttpService] instance as a dependency,
  /// which is used to perform HTTP requests.
  const HomeDataSourceImpl(this._http);

  final HttpService _http;

  @override
  Future<Either<Exception, MenuResponseModel>> getHomeMenu() async {
    try {
      final response = await _http.get(
        '/menu/getSiteMenu',
        queryParameters: {
          'cntry': 'US',
          'lang': 'en',
          'siteNum': '0',
          'sourceCode': 'ORDER.WENDYS',
          'version': '22.1.2',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load menu');
      }

      final parsedResponse = MenuResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (parsedResponse.serviceStatus != 'SUCCESS') {
        throw Exception('Service status is not SUCCESS');
      }

      return Right(parsedResponse);
    } on Exception catch (e) {
      log('Error fetching home menu: $e');

      return Left(e);
    }
  }
}
