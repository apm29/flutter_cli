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
  static const LocaleKey = 'flutter-scaffold-locale';

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String get token => _sharedPreferences.get(SPTokenKey);

  String get locale => _sharedPreferences.get(LocaleKey);

  Future<bool> setToken(String token) {
    return _sharedPreferences.setString(SPTokenKey, token);
  }

  Future<bool> setLocale(String locale) {
    return _sharedPreferences.setString(LocaleKey, locale);
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }
}
