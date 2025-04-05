import 'package:flutter_test/flutter_test.dart';
import 'package:wendys_challenge/features/home/data/models/sub_menu_response_model.dart';

import '../../../../fixtures/fixture_converter.dart';

void main() {
  late final Map<String, dynamic> mockJson;
  late final SubMenuResponseModel responseModel;

  setUpAll(() async {
    mockJson = await fixtureConverter('test/fixtures/sub_menu_fixture.json');
    responseModel = SubMenuResponseModel.fromJson(mockJson);
  });

  group('SubMenuResponseModel', () {
    test('should be a subclass of SubMenuResponse', () {
      expect(responseModel, isA<SubMenuResponseModel>());
    });

    test('should return a valid model when the JSON is valid', () {
      expect(responseModel, isA<SubMenuResponseModel>());
    });

    test('should verify all properties match the JSON values', () {
      expect(responseModel.name, mockJson['name']);
      expect(responseModel.description, mockJson['description']);
      expect(responseModel.displayName, mockJson['displayName']);
      expect(responseModel.baseImageName, mockJson['baseImageName']);
      expect(responseModel.subMenuId, mockJson['subMenuId']);
      expect(
        responseModel.menuItems,
        (mockJson['menuItems'] as List).cast<int>(),
      );
      expect(
        responseModel.attributes,
        Map<String, dynamic>.from(
          mockJson['attributes'] as Map<dynamic, dynamic>,
        ),
      );
      expect(responseModel.productGroupId, mockJson['productGroupId']);
      expect(responseModel.titleTag, mockJson['titleTag']);
      expect(responseModel.metaDescription, mockJson['metaDescription']);
      expect(responseModel.disclaimerCode, mockJson['disclaimerCode']);
    });

    test('should verify all properties types', () {
      expect(responseModel.name, isA<String>());
      expect(responseModel.description, isA<String>());
      expect(responseModel.displayName, isA<String>());
      expect(responseModel.baseImageName, isA<String>());
      expect(responseModel.subMenuId, isA<int>());
      expect(responseModel.menuItems, isA<List<int>>());
      expect(responseModel.attributes, isA<Map<String, dynamic>>());
      expect(responseModel.productGroupId, isA<String?>());
      expect(responseModel.titleTag, isA<String?>());
      expect(responseModel.metaDescription, isA<String?>());
      expect(responseModel.disclaimerCode, isA<String?>());
    });
  });
}
