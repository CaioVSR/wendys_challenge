import 'package:flutter_test/flutter_test.dart';
import 'package:wendys_challenge/core/entities/product_entity.dart';

void main() {
  group('ProductEntity', () {
    const testId = 123;
    const testName = "Dave's Single";
    const testDescription = 'A quarter-pound of fresh beef';
    const testMenuItemId = 1001;
    const testCalories = '490 Cal';
    const testPrice = r'$4.99';

    test('should create instance with required parameters', () {
      const product = ProductEntity(
        id: testId,
        name: testName,
        description: testDescription,
        menuItemId: testMenuItemId,
      );

      expect(product.id, testId);
      expect(product.name, testName);
      expect(product.description, testDescription);
      expect(product.menuItemId, testMenuItemId);
      expect(product.calorieRange, isNull);
      expect(product.priceRange, isNull);
    });

    test('should create instance with all parameters', () {
      const product = ProductEntity(
        id: testId,
        name: testName,
        description: testDescription,
        menuItemId: testMenuItemId,
        calorieRange: testCalories,
        priceRange: testPrice,
      );

      expect(product.id, testId);
      expect(product.name, testName);
      expect(product.description, testDescription);
      expect(product.menuItemId, testMenuItemId);
      expect(product.calorieRange, testCalories);
      expect(product.priceRange, testPrice);
    });

    test('should implement value equality', () {
      const product1 = ProductEntity(
        id: testId,
        name: testName,
        description: testDescription,
        menuItemId: testMenuItemId,
        calorieRange: testCalories,
        priceRange: testPrice,
      );

      const product2 = ProductEntity(
        id: testId,
        name: testName,
        description: testDescription,
        menuItemId: testMenuItemId,
        calorieRange: testCalories,
        priceRange: testPrice,
      );

      const differentProduct = ProductEntity(
        id: 999,
        name: testName,
        description: testDescription,
        menuItemId: testMenuItemId,
        calorieRange: testCalories,
        priceRange: testPrice,
      );

      expect(product1, equals(product2));
      expect(product1 == differentProduct, isFalse);
    });

    test('should support copyWith for creating modified instances', () {
      const original = ProductEntity(
        id: testId,
        name: testName,
        description: testDescription,
        menuItemId: testMenuItemId,
      );

      final updated = original.copyWith(
        calorieRange: testCalories,
        priceRange: testPrice,
      );

      expect(original.calorieRange, isNull);
      expect(original.priceRange, isNull);

      expect(updated.id, testId);
      expect(updated.name, testName);
      expect(updated.description, testDescription);
      expect(updated.menuItemId, testMenuItemId);
      expect(updated.calorieRange, testCalories);
      expect(updated.priceRange, testPrice);
    });

    test('toString should contain all properties', () {
      const product = ProductEntity(
        id: testId,
        name: testName,
        description: testDescription,
        menuItemId: testMenuItemId,
        calorieRange: testCalories,
        priceRange: testPrice,
      );

      final str = product.toString();

      expect(str, contains('id: $testId'));
      expect(str, contains('name: $testName'));
      expect(str, contains('description: $testDescription'));
      expect(str, contains('menuItemId: $testMenuItemId'));
      expect(str, contains('calorieRange: $testCalories'));
      expect(str, contains('priceRange: $testPrice'));
    });
  });
}
