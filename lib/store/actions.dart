import 'package:flutter/widgets.dart';

///
/// author : ciih
/// date : 2020/7/8 1:41 PM
/// description : 
///

class AddAction {}
class AppInitAction{
  BuildContext context;
  AppInitAction(this.context);
}
class HomeIndexSwitchAction{
  BuildContext context;
  int index;
  HomeIndexSwitchAction(this.index,this.context);
}