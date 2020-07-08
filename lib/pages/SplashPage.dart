import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_scaffold/config/Config.dart';
import 'package:flutter_scaffold/generated/l10n.dart';
import 'package:flutter_scaffold/route/route.dart';
import 'package:flutter_scaffold/store/actions.dart';
import 'package:flutter_scaffold/store/stores.dart';

///
/// author : ciih
/// date : 2019-12-25 14:41
/// description :
///
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<JiaYuState>(
      onInit: (store) {
        store.dispatch(AppInitAction(context));
        () async {
          await Future.delayed(Duration(milliseconds: Config.SplashDelay));
          if (mounted) {
            AppRouter.toHomeAndReplaceSelf(context);
          }
        }();
      },
      builder: (context, state) {
        return Scaffold(
          body: SizedBox.expand(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  'assets/images/jiayu_logo.png',
                  width: 100,
                  height: 100,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.all(24),
                      padding: EdgeInsets.all(10),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orangeAccent),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Text(
                        S.of(context).skipLabel,
                        style: TextStyle(color: Colors.orangeAccent),
                      ),
                    ),
                    onTap: () {
                      AppRouter.toHomeAndReplaceSelf(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
