import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/models/paginated_result.dart';
import 'package:movieapp/utils/services.dart';
import 'package:movieapp/utils/typedefs.dart';

class API{
  static final baseUrl = 'https://movieweb.anaconrelo.com';
  static final baseApiUrl = '$baseUrl/api';

  late Dio _dio;

  API(){
    _dio = Dio(BaseOptions(baseUrl: baseApiUrl));
    _dio.interceptors.addAll(
      [
        LoggingInterceptor(),
        ErrorHandlingInterceptor(),
        LogInterceptor(responseBody: true, requestBody: true),
      ],
    );
  }

  Future<List<JsonMap>> getList(String url) async {
    final res = await _dio.get(url);
    if (res.data is List) {
      return (res.data as List).cast<JsonMap>();
    } else {
      return [];
    }
  }

  Future<PaginatedResult> getPage(String url) async {
    final res = await _dio.get(url);
    return PaginatedResult.fromMap(res.data);
  }

  Future<T> getRaw<T>(String url) async {
    final res = await _dio.get(url);
    return res.data as T;
  }

  Future<List<JsonMap>> moviesList() => getList('/movies/list/');
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final data = options.data;
    if (data is FormData) {
      debugPrint(
          '${options.method} ${options.uri} ${data.fields} ${data.files}');
    } else {
      debugPrint('${options.method} ${options.uri} ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    debugPrint(
        'RES: ${response.requestOptions.uri} (${response.statusCode}) ->');
    debugPrint('${response.data}');
    handler.next(response);
  }
}

class ErrorHandlingInterceptor extends Interceptor {
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    final navigatorKey = services<GlobalKey<NavigatorState>>();
    final context = navigatorKey.currentContext!;

    final output = err.response?.data;
    String message = 'Something went wrong. Try again later';
    if (output is JsonMap) {
      if (output.containsKey('non_field_errors')) {
        message = (output['non_field_errors'] as List).join('\n');
      } else if (output.containsKey('message')) {
        message = output['message'];
      } else if (output.containsKey('error')) {
        message = output['error'];
      }
    }
    debugPrint(err.response?.data.toString());
    if (err.requestOptions.method == 'POST') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
    handler.next(err);
  }
}

