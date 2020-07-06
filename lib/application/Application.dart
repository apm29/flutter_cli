import 'package:fluro/fluro.dart';
import 'package:flutter_scaffold/route/route.dart';
import 'package:flutter_scaffold/storage/LocalCache.dart';

///
/// author : ciih
/// date : 2020/7/6 2:48 PM
/// description :
///
class Application {
  static Router router;

  static  init() async {
    Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    await LocalCache().init();
  }
}
