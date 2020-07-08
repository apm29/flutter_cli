import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_scaffold/config/Config.dart';
import 'package:flutter_scaffold/generated/l10n.dart';
import 'package:flutter_scaffold/store/stores.dart';
import 'package:oktoast/oktoast.dart';

///
/// author : ciih
/// date : 2020/7/8 1:48 PM
/// description : 
///
class ReduxApp extends StatelessWidget{
  final Widget firstPage;

  const ReduxApp({Key key, this.firstPage}) : super(key: key);

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
              platform:TargetPlatform.iOS,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            darkTheme: ThemeData.dark().copyWith(
              platform:TargetPlatform.iOS,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: firstPage,
          ),
        ),
      ),
    );
  }
}