import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_scaffold/api/LogInterceptor.dart';
import 'package:flutter_scaffold/api/PrettyLoggerInterceptor.dart';
import 'package:flutter_scaffold/config/Config.dart';
import 'package:flutter_scaffold/model/BaseResp.dart';
import 'package:flutter_scaffold/storage/LocalCache.dart';

typedef JsonProcessor<T> = T Function(dynamic json);

Type typeOf<T>() {
  return T;
}

class RemoteUtils {
  RemoteUtils._() {
    init();
  }

  static bool printLog = true;
  static RemoteUtils _instance;

  static RemoteUtils getInstance() {
    if (_instance == null) {
      _instance = RemoteUtils._();
    }
    return _instance;
  }

  factory RemoteUtils() {
    return getInstance();
  }

  Dio _dio;

  void init() {
    _dio = Dio(BaseOptions(
      method: "POST",
      connectTimeout: Config.ConnectTimeout,
      receiveTimeout: Config.ReceiveTimeout,
      baseUrl: Config.BaseUrl,
    ));
    _dio.interceptors.add(PrettyDioLogger(requestBody: true,responseBody: true));

  }

  Future<BaseResp<T>> post<T>(
    String path, {
    @required JsonProcessor<T> processor,
    Map<String, dynamic> jsonData,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
    ProgressCallback onSendProgress,
  }) async {
    assert(processor != null);
    processor = processor ?? (dynamic raw) => null;
    jsonData = jsonData ?? {};
    cancelToken = cancelToken ?? CancelToken();
    onReceiveProgress = onReceiveProgress ??
        (count, total) {
          ///默认接收进度
        };
    onSendProgress = onSendProgress ??
        (count, total) {
          ///默认发送进度
        };
    Response resp = await _dio.post(
      path,
      options: RequestOptions(
        responseType: ResponseType.json,
        headers: {
          Config.AuthorizationHeader: LocalCache().token,
        },
        contentType:  Config.ContentTypeJson,
        data: jsonData,
      ),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    dynamic map;
    if (resp.headers
        .value(Config.ContentTypeHeader)
        .contains(Config.ContentTypeText)) {
      map = json.decode(resp.data);
    } else {
      map = resp.data;
    }
    dynamic code = map[Config.StatusKey];
    dynamic message = map[Config.MessageKey];
    dynamic token = map[Config.TokenKey];
    dynamic _rawData = map[Config.DataKey];
    T data;
    try {
      if (code == Config.SuccessCode) {
        data = processor(_rawData);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    return BaseResp<T>(code, data, token.toString(), message.toString());
  }

  Future<BaseResp<T>> get<T>(
    String path, {
    @required JsonProcessor<T> processor,
    Map<String, dynamic> queryMap,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    assert(processor != null);
    processor = processor ?? (dynamic raw) => null;
    queryMap = queryMap ?? {};
    cancelToken = cancelToken ?? CancelToken();
    onReceiveProgress = onReceiveProgress ??
        (count, total) {
          ///默认接收进度
        };
    Response resp = await _dio.get(
      path,
      queryParameters: queryMap,
      options: RequestOptions(
          responseType: ResponseType.json,
          headers: {
            Config.AuthorizationHeader: LocalCache().token,
          },
          queryParameters: queryMap,
          contentType: Config.ContentTypeFormUrl),
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    dynamic map;
    if (resp.headers
        .value(Config.ContentTypeHeader)
        .contains(Config.ContentTypeText)) {
      map = json.decode(resp.data);
    } else {
      map = resp.data;
    }
    dynamic code = map[Config.StatusKey];
    dynamic message = map[Config.MessageKey];
    dynamic token = map[Config.TokenKey];
    dynamic _rawData = map[Config.DataKey];
    T data;
    try {
      if (code == Config.SuccessCode) data = processor(_rawData);
    } catch (e, s) {
      print(e);
      print(s);
    }
    return BaseResp<T>(code, data, token.toString(), message.toString());
  }
}
