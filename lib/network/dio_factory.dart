import 'package:dio/dio.dart';
import 'package:grad_project/network/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  static Dio? _dio;

  static void init() {
    const timeout = Duration(seconds: 60);
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: timeout,
      sendTimeout: timeout,
      connectTimeout: timeout,
    );
    _dio = Dio(baseOptions);
    _addInterceptors();
  }

  static void _addInterceptors() {
    _dio!.interceptors.add(PrettyDioLogger(
      requestBody: true,
      responseBody: true,
    ));
  }

  static Future<Response> getData(
    String path, {
    Map<String, dynamic>? queries,
    Map<String, dynamic>? headers,
  }) async {
    return _dio!.get(
      path,
      queryParameters: queries,
    );
  }

  static Future<Response> postData(
    String path, {
    Map<String, dynamic>? queries,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) async {
    return _dio!.post(
      path,
      queryParameters: queries,
      data: data,
    );
  }
}
