import 'package:flutter_scaffold/config/Config.dart';

class BaseResp<T> {
  int code;
  T data;
  String token;
  String message;

  BaseResp(this.code, this.data, this.token, this.message);

  bool get success => code == Config.SuccessCode;
}