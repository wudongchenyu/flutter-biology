import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BaseNetWork {
  factory BaseNetWork() => instance;

  static final BaseNetWork instance = BaseNetWork._internal();

  static BaseOptions baseOptions = BaseOptions(
    baseUrl: 'http://39.100.138.72:8080',
    connectTimeout: 10000,
    receiveTimeout: 3000,
    setRequestContentTypeWhenNoPayload: true,
    headers: {
      HttpHeaders.contentTypeHeader:'application/x-ndjson'
    },
  );

  static Dio dio = Dio()
    ..options = baseOptions
    ..interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          if (kDebugMode) {
            print(
                'request:url==>>>${options.path},params===>>>${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) =>
            {handler.next(response)},
        onError: (DioError e, ErrorInterceptorHandler handler) {
          return handler.next(e);
        }))
    ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  BaseNetWork._internal();
}

class ApiService {
  static final ApiService _instance = ApiService._internal();

  ApiService._internal() {
    if (kDebugMode) {
      print('init');
    }
  }

  factory ApiService() {
    return _instance;
  }

  Future<T> _get<T>(String url, {Map<String, dynamic>? params}) async {
    var response = await BaseNetWork.dio.get(url,
        queryParameters: params,
    );

    return response.data;
  }

  Stream<T> get<T>(String url, {Map<String, dynamic>? params}) =>
      Stream.fromFuture(_get<T>(url, params: params)).asBroadcastStream();

  Future<T> _post<T>(String url, {Map<String, dynamic>? params}) async {
    var response = await BaseNetWork.dio.post(
      url,
      data: json.encode(params) ,
    );
    return response.data;
  }

  Stream<T> post<T>(String url, {Map<String, dynamic>? params}) =>
      Stream.fromFuture(_post<T>(url, params: params)).asBroadcastStream();
}
