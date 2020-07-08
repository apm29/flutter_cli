import 'package:flutter_scaffold/model/BaseResp.dart';
import 'package:flutter_scaffold/api/RemoteUtils.dart';
import 'package:flutter_scaffold/model/Category.dart';

List asList(dynamic value) {
  if (value == null || value is! List) {
    return [];
  } else {
    return value;
  }
}

class Api {
  static Future<BaseResp<List<Category>>> getCategory() {
    return RemoteUtils().post<List<Category>>("/mall/category",
        processor: (s) => asList(s).map((e) => Category.fromJson(e)).toList());
  }
}
