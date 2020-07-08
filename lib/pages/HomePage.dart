import 'package:flutter/material.dart';
import 'package:flutter_scaffold/components/AutoSlideDownWidget.dart';
import 'package:flutter_scaffold/generated/l10n.dart';
import 'package:flutter_scaffold/pages/home/CategoryPage.dart';
import 'package:flutter_scaffold/pages/home/DashboardPage.dart';
import 'package:flutter_scaffold/pages/home/MinePage.dart';
import 'package:flutter_scaffold/store/actions.dart';
import 'package:flutter_scaffold/store/stores.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:flutter_scaffold/api/Api.dart';
import 'dart:math' as math;

///
/// author : ciih
/// date : 2020/7/8 1:50 PM
/// description :
///
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  void _incrementCounter(BuildContext context) async {
    await Api.getCategory();
    StoreProvider.of<JiaYuState>(context, listen: false).dispatch(AddAction());
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: StoreConnector<JiaYuState, int>(
        converter: (store) {
          return store.state.homePageIndex;
        },
        builder: (ctx, homePageIndex) {
          return IndexedStack(
            sizing: StackFit.expand,
            children: <Widget>[DashboardPage(), CategoryPage(), MinePage()],
            index: homePageIndex,
          );
        },
      ),
      bottomNavigationBar: StoreConnector<JiaYuState, bool>(
        converter: (store) {
          return store.state.hideHomeNavigationBar;
        },
        builder: (context, hide) {
          return AutoSlideDownWidget(
            hide: hide,
            child: buildBottomNavigationBar(context),
          );
        },
      ),
      endDrawer: Drawer(
        child: ReduxDevTools(store),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ///---------------------生命周期相关---------------------
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); //添加观察者
  }

  ///生命周期变化时回调
  //  resumed:应用可见并可响应用户操作
  //  inactive:用户可见，但不可响应用户操作
  //  paused:已经暂停了，用户不可见、不可操作
  //  suspending：应用被挂起，此状态IOS永远不会回调
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("JiaYu  didChangeAppLifecycleState: $state");
  }

  ///当前系统改变了一些访问性活动的回调
  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
    print("JiaYu didChangeAccessibilityFeatures");
  }

  /// Called when the system is running low on memory.
  ///低内存回调
  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
    print("JiaYu didHaveMemoryPressure");
  }

  /// Called when the system tells the app that the user's locale has
  /// changed. For example, if the user changes the system language
  /// settings.
  ///用户本地设置变化时调用，如系统语言改变
  @override
  void didChangeLocales(List<Locale> locale) {
    super.didChangeLocales(locale);
    print("JiaYu didChangeLocales");
  }

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  ///应用尺寸改变时回调，例如旋转
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    Size size = WidgetsBinding.instance.window.physicalSize;
    print("JiaYu didChangeMetrics  ：宽：${size.width} 高：${size.height}");
  }

  /// {@macro on_platform_brightness_change}
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    print("JiaYu didChangePlatformBrightness");
  }

  ///文字系数变化
  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
    print(
        "JiaYu didChangeTextScaleFactor  ：${WidgetsBinding.instance.window.textScaleFactor}");
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this); //销毁观察者
  }

  ///---------------------生命周期相关---------------------
}

StoreConnector<JiaYuState, int> buildBottomNavigationBar(BuildContext context) {
  var marginHorizontal = 12.0;
  return StoreConnector<JiaYuState, int>(
    converter: (store) => store.state.homePageIndex,
    builder: (ctx, index) => Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Theme.of(context).accentColor,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
        child: BottomAppBar(
          elevation: 12,
          //shape: CircularNotchedRectangleWithMargin(marginHorizontal),
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: (index) {
              store.dispatch(HomeIndexSwitchAction(index, context));
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(S.of(context).appName),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                title: Text(S.of(context).appName),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(S.of(context).appName),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


class CircularNotchedRectangleWithMargin extends NotchedShape {
  final double margin;

  const CircularNotchedRectangleWithMargin(this.margin);

  @override
  Path getOuterPath(Rect oldHost, Rect oldGuest) {
    Rect host = Rect.fromLTWH(
        oldHost.left + margin, 0, oldHost.width - 2 * margin, oldHost.height);
    Rect guest = Rect.fromLTRB(oldGuest.left - margin, oldGuest.top,
        oldGuest.right - margin, oldGuest.bottom);
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final double notchRadius = guest.width / 2.0;

    // We build a path for the notch from 3 segments:
    // Segment A - a Bezier curve from the host's top edge to segment B.
    // Segment B - an arc with radius notchRadius.
    // Segment C - a Bezier curve from segment B back to the host's top edge.
    //
    // A detailed explanation and the derivation of the formulas below is
    // available at: https://goo.gl/Ufzrqn

    const double s1 = 15.0;
    const double s2 = 1.0;

    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA);
    final double p2yB = math.sqrt(r * r - p2xB * p2xB);

    final List<Offset> p = List<Offset>(6);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) p[i] += guest.center;

    double tRadius = 12;

    return Path()
      ..moveTo(host.left + tRadius, host.top)
      ..lineTo(p[0].dx, p[0].dy)
      ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
      ..arcToPoint(
        p[3],
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
      ..lineTo(host.right - tRadius, host.top)
      ..arcToPoint(
        Offset(host.right, host.top + tRadius),
        radius: Radius.circular(tRadius),
      )
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..lineTo(host.left, host.top + tRadius)
      ..arcToPoint(
        Offset(host.left + tRadius, host.top),
        radius: Radius.circular(tRadius),
      )
      ..close();
  }
}

