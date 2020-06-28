import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioLogInterceptor extends Interceptor{

  final Level level;

  DioLogInterceptor({this.level = Level.RESP});

  @override
  Future onRequest(RequestOptions req) {
    debugPrint("====================================================================================================");
    debugPrint("REQUEST:");
    debugPrint("====================================================================================================");
    debugPrint("Method:${req.method},Url:${req.baseUrl + req.path}");
    debugPrint("Headers:");
    printFormat(req.headers);
    debugPrint("QueryParams:${req.queryParameters}");
    if (req.data.runtimeType != FormData) {
      debugPrint("Data: ${req.data.runtimeType}");
      printFormat(req.data);
    }
    debugPrint("====================================================================================================");
    return Future.value();
  }

  @override
  Future onError(DioError err) {
    debugPrint("====================================================================================================");
    debugPrint("ERROR:");
    debugPrint("====================================================================================================");
    debugPrint("Message:${err.message}");
    debugPrint("Error:${err.error}");
    debugPrint("Data:");
    print(err.response);
    debugPrint("Type:${err.type}");
    debugPrint("====================================================================================================");
    return Future.value();
  }

  @override
  Future onResponse(Response resp) {
    if(level == Level.DETAIL) {
      debugPrint("====================================================================================================");
      debugPrint("REQUEST:");
      debugPrint("====================================================================================================");
      debugPrint(
          "Method:${resp.request.method},Url:${resp.request.baseUrl +
              resp.request.path}");
      debugPrint("Headers:");
      printFormat(resp.request.headers);
      debugPrint("QueryParams:${resp.request.queryParameters}");
      if (resp.request.data.runtimeType != FormData) {
        debugPrint("Data:");
        printFormat(resp.request.data);
      }
    }
    debugPrint("====================================================================================================");
    debugPrint("RESULT:");
    debugPrint("====================================================================================================");
    debugPrint("Headers:\n${resp.headers}");
    debugPrint("Data:");
    printFormat(resp.data);
    debugPrint("Redirect:${resp.redirects}");
    debugPrint("StatusCode:${resp.statusCode}");
    debugPrint("Extras:${resp.extra}");
    debugPrint(" ====================================================================================================");
    return Future.value();
  }

  void printFormat(Object jsonObject, {step = 100}) {
    if(jsonObject is String){
      debugPrint('---------------WARNING jsonObject\'s type is '
          'String--------------');
      jsonObject = json.decode(jsonObject);
    }
    String content = formatJson(jsonObject);
    debugPrint(content);
  }

  String formatJson(Object content) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettifying = encoder.convert(content);
    return prettifying;
  }
}

enum Level{
  RESP,DETAIL
}