import 'package:flutter_test/flutter_test.dart';
import 'package:wendys_challenge/features/home/data/models/menu_lists_response_model.dart';
import 'package:wendys_challenge/features/home/data/models/menu_response_model.dart';

import '../../../../fixtures/fixture_converter.dart';

void main() {
  late final Map<String, dynamic> mockJson;
  late final MenuResponseModel responseModel;

  setUpAll(() async {
    mockJson = await fixtureConverter(
      'test/fixtures/menu_response_fixture.json',
    );

    responseModel = MenuResponseModel.fromJson(mockJson);
  });

  group('MenuResponseModel', () {
    test('should be a subclass of MenuResponseModel', () {
      expect(responseModel, isA<MenuResponseModel>());
    });

    test('should correctly parse service status and menu lists', () {
      expect(responseModel.serviceStatus, isA<String>());
      expect(responseModel.menuLists, isA<MenuListsResponseModel>());
    });
  });
}
