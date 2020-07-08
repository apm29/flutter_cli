import 'package:flutter_scaffold/store/actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter_scaffold/store/stores.dart';

///
/// author : ciih
/// date : 2020/7/8 1:42 PM
/// description :
///
JiaYuState appReducer(JiaYuState state, action) {
  return appStateReducer(state, action)
    ..loading = loadingReducer(state.loading, action);
}

final appStateReducer = combineReducers<JiaYuState>(
  [
    TypedReducer<JiaYuState, AddAction>((state, action) {
      state.count += 1;
      return state;
    }),
    TypedReducer<JiaYuState, AppInitAction>((state, action) {
      print(action);
      return state;
    }),
    TypedReducer<JiaYuState, HomeIndexSwitchAction>((state, action) {
      print(action.index);
      return state..homePageIndex = action.index;
    }),
  ],
);
final loadingReducer = combineReducers<int>([

]);
