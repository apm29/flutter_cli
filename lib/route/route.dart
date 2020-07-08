import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_scaffold/application/Application.dart';
import 'package:flutter_scaffold/pages/HomePage.dart';
import 'package:flutter_scaffold/pages/SplashPage.dart';

///
/// author : ciih
/// date : 2020/7/6 5:15 PM
/// description : 
///
class Routes {
  static String root = "/";
  static String home = "/home";
  static String login = "/login";

  static String keyId = "id";
  static String keyData = "id";
  static String keyType = "type";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(handlerFunc: (
        BuildContext context,
        Map<String, List<String>> params,
        ) {
      print("ROUTE WAS NOT FOUND !!!");
      return NotFoundPage();
    });

    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画，可以看上图
    /// 我这边先不设置默认的转场动画，转场动画在下面会讲，可以在另外一个地方设置（可以看NavigatorUtil类）
    router.define(root, handler: splashHandler);
    router.define(home, handler: homeHandler);
  }
}

/// 跳转到首页Splash
final splashHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return SplashPage();
  },
);

final homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return HomePage();
  },
);

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('抱歉'),
      ),
      body: Center(
        child: Text('404 Not Found 路由未找到'),
      ),
    );
  }
}

final defaultTransitionType = TransitionType.material;
final defaultTransitionDuration = Duration(milliseconds: 2800);

class AppRouter {
  static Future toHomeAndReplaceSelf(BuildContext context) {
    if (ModalRoute.of(context).settings.name == Routes.home) {
      return Future.value();
    }
    return Application.router.navigateTo(
      context,
      Routes.home,
      replace: true,
      transition: defaultTransitionType,
    );
  }

  static Future toSplash(BuildContext context) {
    return Application.router.navigateTo(
      context,
      Routes.root,
      transition: defaultTransitionType,
    );
  }

}