import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  SharedPreferences _sharedPreferences;

  Cache._();

  static Cache _cacheInstance;

  factory Cache() {
    if (_cacheInstance == null) {
      _cacheInstance = Cache._();
    }
    return _cacheInstance;
  }

  static const SPTokenKey = 'flutter-scaffold-token';

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String get token => _sharedPreferences.get(SPTokenKey);


  void setToken(String token) {
    try {
      _sharedPreferences.setString(SPTokenKey, token);
    } catch (e) {
    }
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }
}
