import 'package:flutter/material.dart';
import 'package:flutter_scaffold/application/Application.dart';
import 'package:flutter_scaffold/pages/SplashPage.dart';
import 'package:flutter_scaffold/store/ReduxApp.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Application.init();
  runApp(
    ReduxApp(
      firstPage: SplashPage(),
    ),
  );
}
