import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

///http请求成功回调
typedef Callback<T> = void Function(dynamic data);

class Ajax {
  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';

  Dio _client;

  static final Ajax _instance = Ajax._internal();

  factory Ajax() => _instance;

  Dio get client => _client;

  /// 创建 dio 实例对象
  Ajax._internal() {
    if (_client == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = BaseOptions(
        baseUrl: "http://webapi.wanzhuang-app.com",
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      _client = Dio(options);
    }
  }

  void get({
    @required String url,
    Map<String, dynamic> params,
    Options options,
    Callback callback,
  }) {
    _request(
      url: url,
      params: params,
      method: GET,
      options: options,
      callback: callback,
    );
  }

  void post({
    @required String url,
    Map<String, dynamic> params,
    Options options,
    Callback callback,
  }) {
    _request(
      url: url,
      params: params,
      method: POST,
      options: options,
      callback: callback,
    );
  }

  void _request({
    @required String url,
    String method,
    data,
    Map<String, dynamic> params,
    Options options,
    Callback callback,
  }) {
    //设置默认值
    params = params ?? {};
    method = method ?? 'GET';
    options = options ??
        Options(
          method: method,
        );
    try {
      Future<Response<Map<dynamic, dynamic>>> response = _client.request(
        url,
        data: data,
        queryParameters: params,
        options: options,
      );
      response.then((value) {
        Map data = jsonDecode(value.toString());
        callback(data);
      });
    } catch (e) {
      print("报错了");
    }
  }
}
