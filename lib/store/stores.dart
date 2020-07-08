import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_scaffold/storage/LocalCache.dart';
import 'package:flutter_scaffold/store/reducers.dart';
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



class JiaYuState {
  int count = 0;
  Locale locale;

  int homePageIndex = 0;
  bool hideHomeNavigationBar = false;

  int loading = 0;

  JiaYuState() : this.locale = Locale(LocalCache().locale ?? 'zh');
}