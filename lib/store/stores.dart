import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_scaffold/config/Config.dart';
import 'package:flutter_scaffold/generated/l10n.dart';
import 'package:flutter_scaffold/storage/LocalCache.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

///
/// author : ciih
/// date : 2020/7/6 2:24 PM
/// description :
///
final DevToolsStore<JiaYuState> store = DevToolsStore<JiaYuState>(
  appReducer,
  initialState: JiaYuState(),
  middleware: <Middleware<JiaYuState>>[],
);

JiaYuState appReducer(JiaYuState state, action) {
  return appStateReducer(state, action);
}

final appStateReducer = combineReducers<JiaYuState>(
  [
    TypedReducer<JiaYuState, AddAction>((state, action) {
      state.count += 1;
      return state;
    }),
  ],
);

class JiaYuState {
  int count = 0;
  Locale locale;

  JiaYuState() : this.locale = Locale(LocalCache().locale ?? 'zh');
}

class ReduxApp extends StatelessWidget {
  final Widget child;

  const ReduxApp({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: OKToast(
        //StoreConnector<JiaYuState, Locale> provide locale for material app
        child: StoreConnector<JiaYuState, Locale>(
          converter: (s) => s.state.locale,
          builder: (context, locale) => MaterialApp(
            debugShowCheckedModeBanner: Config.AppDebug,
            localizationsDelegates: [
              // ... app-specific localization delegate[s] here
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate
            ],
            locale: locale,
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            darkTheme: ThemeData.dark().copyWith(
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: child,
          ),
        ),
      ),
    );
  }
}

class AddAction {}
class AppInitAction{
  BuildContext context;
  AppInitAction(this.context);
}
