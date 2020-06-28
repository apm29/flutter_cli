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

  final tokenKey = 'token';
  final localeKey = 'locale';
  final houseKey = 'house';
  final roleKey = 'role';



  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String get token => _sharedPreferences.get(tokenKey);

  String get locale => _sharedPreferences.get(localeKey);

  String get currentHouseId => _sharedPreferences.get(houseKey);

  String get currentRoleId =>  _sharedPreferences.get(roleKey);

  void setToken(String token) {
    try {
      _sharedPreferences.setString(tokenKey, token);
    } catch (e) {
    }
  }

  void setLocale(String locale) {
    try {
      _sharedPreferences.setString(localeKey, locale);
    } catch (e) {
    }
  }

  void setCurrentHouseId(dynamic id) {
    try {
      _sharedPreferences.setString(houseKey, id.toString());
    } catch (e) {
    }
  }

  void setCurrentRoleId(dynamic id) {
    try {
      _sharedPreferences.setString(roleKey, id.toString());
    } catch (e) {
    }
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }
}
