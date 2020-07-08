///
/// author : ciih
/// date : 2020/7/8 9:26 AM
/// description : 
///
import 'dart:convert' show json;
import 'package:flutter/foundation.dart';

void tryCatch(Function f) {
  try {
    f?.call();
  } catch (e, stack) {
    debugPrint('$e');
    debugPrint('$stack');
  }
}

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  if (value != null) {
    final String valueS = value.toString();
    if (0 is T) {
      return int.tryParse(valueS) as T;
    } else if (0.0 is T) {
      return double.tryParse(valueS) as T;
    } else if ('' is T) {
      return valueS as T;
    } else if (false is T) {
      if (valueS == '0' || valueS == '1') {
        return (valueS == '1') as T;
      }
      return bool.fromEnvironment(value.toString()) as T;
    }
  }
  return null;
}

class Category {
  Category({
    this.id,
    this.name,
    this.keywords,
    this.description,
    this.pid,
    this.iconUrl,
    this.picUrl,
    this.level,
    this.sortOrder,
    this.addTime,
    this.updateTime,
    this.deleted,
    this.children,
  });

  factory Category.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }

    final List<Category> children =
    jsonRes['children'] is List ? <Category>[] : null;
    if (children != null) {
      for (final dynamic item in jsonRes['children']) {
        if (item != null) {
          tryCatch(() {
            children.add(Category.fromJson(asT<Map<String, dynamic>>(item)));
          });
        }
      }
    }
    return Category(
      id: asT<int>(jsonRes['id']),
      name: asT<String>(jsonRes['name']),
      keywords: asT<String>(jsonRes['keywords']),
      description: asT<String>(jsonRes['description']),
      pid: asT<int>(jsonRes['pid']),
      iconUrl: asT<String>(jsonRes['iconUrl']),
      picUrl: asT<String>(jsonRes['picUrl']),
      level: asT<String>(jsonRes['level']),
      sortOrder: asT<int>(jsonRes['sortOrder']),
      addTime: asT<String>(jsonRes['addTime']),
      updateTime: asT<String>(jsonRes['updateTime']),
      deleted: asT<int>(jsonRes['deleted']),
      children: children,
    );
  }

  int id;
  String name;
  String keywords;
  String description;
  int pid;
  String iconUrl;
  String picUrl;
  String level;
  int sortOrder;
  String addTime;
  String updateTime;
  int deleted;
  List<Category> children;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'keywords': keywords,
    'description': description,
    'pid': pid,
    'iconUrl': iconUrl,
    'picUrl': picUrl,
    'level': level,
    'sortOrder': sortOrder,
    'addTime': addTime,
    'updateTime': updateTime,
    'deleted': deleted,
    'children': children,
  };
  @override
  String toString() {
    return json.encode(this);
  }
}