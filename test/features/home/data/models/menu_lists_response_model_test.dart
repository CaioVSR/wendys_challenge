import 'package:flutter_test/flutter_test.dart';
import 'package:wendys_challenge/features/home/data/models/menu_item_response_model.dart';
import 'package:wendys_challenge/features/home/data/models/menu_lists_response_model.dart';
import 'package:wendys_challenge/features/home/data/models/sub_menu_response_model.dart';

import '../../../../fixtures/fixture_converter.dart';

void main() {
  late final Map<String, dynamic> mockJson;
  late final MenuListsResponseModel responseModel;

  setUpAll(() async {
    mockJson = await fixtureConverter('test/fixtures/menu_lists_fixture.json');
    responseModel = MenuListsResponseModel.fromJson(mockJson);
  });

  group('MenuListsResponseModel', () {
    test('should be a subclass of MenuListsResponseModel', () {
      expect(
        MenuListsResponseModel.fromJson(mockJson),
        isA<MenuListsResponseModel>(),
      );
    });

    test('should correctly parse menu items and sub menus', () {
      expect(responseModel.menuItems, isA<List<MenuItemResponseModel>>());
      expect(responseModel.subMenus, isA<List<SubMenuResponseModel>>());
    });
  });
}
