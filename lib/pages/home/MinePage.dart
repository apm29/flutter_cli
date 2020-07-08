import 'package:flutter/material.dart';
import 'package:flutter_scaffold/route/route.dart';

///
/// author : ciih
/// date : 2020/7/8 1:58 PM
/// description :
///
class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text('MinePage'),
        onPressed: () => AppRouter.toSplash(context),
      ),
    );
  }
}
