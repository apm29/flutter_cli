import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {
  SharedPreferences _sharedPreferences;

  LocalCache._();

  static LocalCache _cacheInstance;

  factory LocalCache() {
    if (_cacheInstance == null) {
      _cacheInstance = LocalCache._();
    }
    return _cacheInstance;
  }

  static const SPTokenKey = 'flutter-scaffold-token';

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String get token => _sharedPreferences.get(SPTokenKey);

  Future<bool> setToken(String token) {
      return _sharedPreferences.setString(SPTokenKey, token);
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }
}
