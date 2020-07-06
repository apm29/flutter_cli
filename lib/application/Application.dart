import 'package:flutter_scaffold/storage/LocalCache.dart';

///
/// author : ciih
/// date : 2020/7/6 2:48 PM
/// description :
///
class Application {
  static init() async {
    await LocalCache().init();
  }
}
