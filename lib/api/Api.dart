import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cli/api/LogInterceptor.dart';
import 'package:flutter_cli/config/Config.dart';
import 'package:flutter_cli/entity/BaseResp.dart';
import 'package:flutter_cli/storage/Cache.dart';

typedef JsonProcessor<T> = T Function(dynamic json);

class Api {
  Api._() {
    init();
  }

  static bool printLog = true;
  static Api _instance;

  static Api getInstance() {
    if (_instance == null) {
      _instance = Api._();
    }
    return _instance;
  }

  factory Api() {
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
    _dio.interceptors.add(DioLogInterceptor());
  }

  Future<BaseResp<T>> post<T>(
    String path, {
    @required JsonProcessor<T> processor,
    Map<String, dynamic> formData,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
    ProgressCallback onSendProgress,
    useFormData: false,
  }) async {
    assert(processor != null);
    processor = processor ?? (dynamic raw) => null;
    formData = formData ?? {};
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
          Config.AuthorizationHeader: Cache().token,
        },
        contentType: useFormData
            ? Config.ContentTypeFormDataValue
            : Config.ContentTypeFormUrlEncodeValue,
        data: useFormData ? FormData.fromMap(formData) : formData,
      ),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    dynamic map;
    if (resp.headers
        .value(Config.ContentTypeHeader)
        .contains(Config.ContentTypeTextPlainValue)) {
      map = json.decode(resp.data);
    } else {
      map = resp.data;
    }
    dynamic code = map["Code"];
    dynamic message = map["Msg"];
    dynamic token = map["Token"];
    dynamic _rawData = map["Data"];
    T data;
    try {
      if (code == 200) data = processor(_rawData);
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
            Config.AuthorizationHeader: Cache().token,
          },
          queryParameters: queryMap,
          contentType: Config.ContentTypeFormUrlEncodeValue),
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    dynamic map;
    if (resp.headers
        .value(Config.ContentTypeHeader)
        .contains(Config.ContentTypeTextPlainValue)) {
      map = json.decode(resp.data);
    } else {
      map = resp.data;
    }
    dynamic code = map["Code"];
    dynamic message = map["Msg"];
    dynamic token = map["Token"];
    dynamic _rawData = map["Data"];
    T data;
    try {
      if (code == 200) data = processor(_rawData);
    } catch (e, s) {
      print(e);
      print(s);
    }
    return BaseResp<T>(
        code, data, token.toString(), message.toString());
  }
}
