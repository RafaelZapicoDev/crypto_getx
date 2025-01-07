import 'package:crypto_getx/consts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpService {
  //service
  final Dio _dio = Dio();
  HttpService() {
    _configureDio();
  }

  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: "https://api.cryptorank.io/v1/",
      queryParameters: {"api_key": "//ADD YOUR KEY HERE"},
    );
  }

  Future<dynamic> get(String path) async {
    try {
      Response response = await _dio.get(path);
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
