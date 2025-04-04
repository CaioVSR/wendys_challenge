import 'package:flutter_test/flutter_test.dart';
import 'package:wendys_challenge/features/home/data/models/menu_item_response_model.dart';

import '../../../../fixtures/fixture_converter.dart';

void main() {
  late final Map<String, dynamic> mockJson;
  late final MenuItemResponseModel responseModel;

  setUpAll(() async {
    mockJson = await fixtureConverter('test/fixtures/menu_item_fixture.json');
    responseModel = MenuItemResponseModel.fromJson(mockJson);
  });

  group('MenuItemResponsemodel', () {
    test('should be a subclass of MenuItemResponse', () {
      expect(responseModel, isA<MenuItemResponseModel>());
    });

    test('should return a valid model when the JSON is valid', () {
      expect(responseModel, isA<MenuItemResponseModel>());
    });

    test('should verify all properties match the JSON values', () {
      expect(responseModel.calorieRange, mockJson['calorieRange']);
      expect(responseModel.description, mockJson['description']);
      expect(responseModel.menuItemId, mockJson['menuItemId']);
      expect(responseModel.name, mockJson['name']);
      expect(responseModel.priceRange, mockJson['priceRange']);
    });

    test('should verify all properties types', () {
      expect(responseModel.calorieRange, isA<String>());
      expect(responseModel.description, isA<String>());
      expect(responseModel.menuItemId, isA<int>());
      expect(responseModel.name, isA<String>());
      expect(responseModel.priceRange, isA<String>());
    });
  });
}
