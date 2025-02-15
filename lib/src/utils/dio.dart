import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:filmy/src/utils/urls.dart';

class AppDio {
  AppDio() {
    initClient();
  }

//for api client testing only
  AppDio.test({required this.dio});

  Dio? dio;
  BaseOptions? _baseOptions;

  initClient() async {
    _baseOptions = BaseOptions(
        baseUrl: Urls.baseUrl,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 1000000),
        followRedirects: false,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true);

    dio = Dio(_baseOptions);
  }

  ///dio get
  Future<Response> get({String? url}) {
    return dio!.get(url!);
  }

  ///dio  post
  Future<Response> post({String? url, var data}) {
    return dio!.post(url!, data: data);
  }
}
