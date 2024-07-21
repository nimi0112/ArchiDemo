//Created by Nimish Nandwana on 17/11/2021.

import 'package:dio/dio.dart';

import '../api_constants.dart';

class DioProvider {
  //return the previously created instance
  factory DioProvider() {
    return _instance;
  }

  // private constructor restricted to this class itself
  DioProvider._internal();

  static final DioProvider _instance = DioProvider._internal();

  static Dio? _dio;

  static Dio getDio() {
    if (_dio != null) {
      return _dio!;
    }
    _dio = Dio();

    final dioOptions = BaseOptions(
      connectTimeout: const Duration(milliseconds: connectTimeoutInMillis),
      receiveTimeout: const Duration(milliseconds: receiveTimeoutInMillis),
    )..baseUrl = baseUrl;

    _dio!.options = dioOptions;

    return _dio!;
  }
}
