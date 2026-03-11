import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com',
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        error: true,
        request: true,

      ),
    );
  }
}
