import 'package:shared_preferences/shared_preferences.dart';

/// An interface for performing basic string-based caching operations.
///
/// This abstraction allows for different cache implementations to be used
/// throughout the app, simplifying testing by enabling mock implementations.
/// It defines a minimal set of operations needed for basic caching.
abstract class CacheService {
  /// Retrieves a string value from the cache corresponding to the given [key].
  ///
  /// Returns a [Future] that completes with the stored string value, or `null`
  /// if the key doesn't exist in the cache.
  Future<String?> getString(String key);

  /// Stores a string value in the cache using the given [key].
  ///
  /// The [value] parameter is the string to store in the cache.
  ///
  /// Returns a [Future] that completes with `true` if the operation
  /// was successful, or `false` otherwise.
  Future<bool> setString(String key, String value);

  /// Removes the value associated with the given [key] from the cache.
  ///
  /// Returns a [Future] that completes with `true` if the value was removed,
  /// or `false` if the operation failed or the key wasn't found.
  Future<bool> remove(String key);
}

/// A [CacheService] implementation using SharedPreferences.
///
/// This implementation provides persistent storage for string values
/// using the device's local storage via the SharedPreferences API. 
/// Values stored here will persist across app restarts.
class CacheServiceImpl implements CacheService {
  /// Creates a new instance of [CacheServiceImpl].
  ///
  /// The [_sharedPreferences] parameter is a [Future] that resolves to 
  /// the SharedPreferences instance, 
  /// typically obtained from [SharedPreferences.getInstance].
  const CacheServiceImpl(this._sharedPreferences);

  final Future<SharedPreferences> _sharedPreferences;

  @override
  Future<String?> getString(String key) async =>
      (await _sharedPreferences).getString(key);

  @override
  Future<bool> setString(String key, String value) async =>
      (await _sharedPreferences).setString(key, value);

  @override
  Future<bool> remove(String key) async =>
      (await _sharedPreferences).remove(key);
}
