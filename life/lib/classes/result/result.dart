import 'dart:convert';
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(genericArgumentFactories: true)
class Result<T> {
  late final int code;
  late final String message;
  late final bool success;
  late final DateTime timestamp;
  late final T? data;
  Result(
      {required this.code,
      required this.message,
      required this.success,
      required this.timestamp,
      this.data});

  factory Result.fromJson(String jsonString) {
    Map<String, dynamic> result = json.decode(jsonString);
    return Result(
        code: result['code'],
        message: result['message'],
        success: result['success'],
        timestamp: DateTime.parse(result['timestamp']),
        data: result['data'].cast<T>(),);
  }

}

@JsonSerializable(genericArgumentFactories: true)
class PageResult<T> extends Result<T> {
  final int current;
  final int size;
  final double total;
  PageResult({
    required this.current,
    required this.size,
    required this.total,
    required code,
    required message,
    required success,
    required timestamp,
    data,
  }) : super(
            code: code,
            message: message,
            success: success,
            timestamp: timestamp,
            data: data);

  factory PageResult.fromJson(String jsonString) {
    Map<String, dynamic> result = json.decode(jsonString);
    return PageResult(
        current: result['current'],
        size: result['size'],
        total: result['total'],
        code: result['code'],
        message: result['message'],
        success: result['success'],
        timestamp: result['timestamp'],
        data: result['data'].cast<T>(),);
  }
}


@JsonSerializable(genericArgumentFactories: true)
class Results<T> {
  late final int code;
  late final String message;
  late final bool success;
  late final DateTime timestamp;
  late final List<T> data;

  Results(
      {required this.code,
        required this.message,
        required this.success,
        required this.timestamp,
        required this.data});

  factory Results.fromJson(String jsonString) {
    Map<String, dynamic> result = json.decode(jsonString);
    return Results(
      code: result['code'],
      message: result['message'],
      success: result['success'],
      timestamp: DateTime.parse(result['timestamp']),
      data: result['data'].cast<T>(),);
  }

}

@JsonSerializable(genericArgumentFactories: true)
class PageResults<T> {
  final int current;
  final int size;
  final int total;
  late final int code;
  late final String message;
  late final bool success;
  late final DateTime timestamp;
  late final List<T> data;
  PageResults({
    required this.current,
    required this.size,
    required this.total,
    required this.code,
    required this.message,
    required this.success,
    required this.timestamp,
    required this.data,
  }) ;

  factory PageResults.fromJson(String jsonString) {
    Map<String, dynamic> result = json.decode(jsonString);
    return PageResults(
      current: result['current'],
      size: result['size'],
      total: result['total'],
      code: result['code'],
      message: result['message'],
      success: result['success'],
      timestamp: DateTime.parse(result['timestamp']),
      data: result['data'].cast<T>(),);
  }
}

