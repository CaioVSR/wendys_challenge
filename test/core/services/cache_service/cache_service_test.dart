import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wendys_challenge/core/services/cache_service/cache_service.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late CacheServiceImpl cacheService;
  late Future<SharedPreferences> sharedPreferencesFuture;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    sharedPreferencesFuture = Future.value(mockSharedPreferences);
    cacheService = CacheServiceImpl(sharedPreferencesFuture);
  });

  group('CacheServiceImpl', () {
    const testKey = 'test_key';
    const testValue = 'test_value';

    group('getString', () {
      test('should return value when key exists', () async {
        when(
          () => mockSharedPreferences.getString(testKey),
        ).thenReturn(testValue);

        final result = await cacheService.getString(testKey);

        expect(result, testValue);
        verify(() => mockSharedPreferences.getString(testKey)).called(1);
      });

      test('should return null when key does not exist', () async {
        when(() => mockSharedPreferences.getString(testKey)).thenReturn(null);

        final result = await cacheService.getString(testKey);

        expect(result, isNull);
        verify(() => mockSharedPreferences.getString(testKey)).called(1);
      });
    });

    group('setString', () {
      test('should return true when saving is successful', () async {
        when(
          () => mockSharedPreferences.setString(testKey, testValue),
        ).thenAnswer((_) => Future.value(true));

        final result = await cacheService.setString(testKey, testValue);

        expect(result, isTrue);
        verify(
          () => mockSharedPreferences.setString(testKey, testValue),
        ).called(1);
      });

      test('should return false when saving fails', () async {
        when(
          () => mockSharedPreferences.setString(testKey, testValue),
        ).thenAnswer((_) => Future.value(false));

        final result = await cacheService.setString(testKey, testValue);

        expect(result, isFalse);
        verify(
          () => mockSharedPreferences.setString(testKey, testValue),
        ).called(1);
      });
    });

    group('remove', () {
      test('should return true when removing is successful', () async {
        when(
          () => mockSharedPreferences.remove(testKey),
        ).thenAnswer((_) => Future.value(true));

        final result = await cacheService.remove(testKey);

        expect(result, isTrue);
        verify(() => mockSharedPreferences.remove(testKey)).called(1);
      });

      test('should return false when removing fails', () async {
        when(
          () => mockSharedPreferences.remove(testKey),
        ).thenAnswer((_) => Future.value(false));

        final result = await cacheService.remove(testKey);

        expect(result, isFalse);
        verify(() => mockSharedPreferences.remove(testKey)).called(1);
      });
    });

    test('should properly await SharedPreferences instance', () async {
      final delayedPrefs = Future.delayed(
        const Duration(milliseconds: 100),
        () => mockSharedPreferences,
      );

      final delayedCacheService = CacheServiceImpl(delayedPrefs);

      when(
        () => mockSharedPreferences.getString(testKey),
      ).thenReturn(testValue);

      final result = await delayedCacheService.getString(testKey);

      expect(result, testValue);
      verify(() => mockSharedPreferences.getString(testKey)).called(1);
    });
  });
}
