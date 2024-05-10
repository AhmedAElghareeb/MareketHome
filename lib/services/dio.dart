import 'package:dio/dio.dart';

class DioHelper {
  static final i = DioHelper();

  final _dio = Dio(
    BaseOptions(
      baseUrl: "https://student.valuxapps.com/api/",
      receiveDataWhenStatusError: true,
    ),
  );

  Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    String? lang = "en",
    String? token,
  }) async {
    _dio.options.headers = {
      "Authorization": token,
      "lang": lang,
      "Content-Type" : "application/json",
    };
    return await _dio.get(
      path,
      queryParameters: query,
    );
  }

  Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? lang = "en",
    String? token,
  }) async {
    _dio.options.headers = {
      "Authorization": token,
      "lang": lang,
      "Content-Type" : "application/json",
    };
    return await _dio.post(
      path,
      queryParameters: query,
      data: data,
    );
  }

  Future<Response> putData({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? lang = "en",
    String? token,
  }) async {
    _dio.options.headers = {
      "Authorization": token,
      "lang": lang,
      "Content-Type" : "application/json",
    };
    return await _dio.put(
      path,
      queryParameters: query,
      data: data,
    );
  }
}
