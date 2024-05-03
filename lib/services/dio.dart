import 'package:dio/dio.dart';

class DioHelper {
  static final i = DioHelper();

  final _dio = Dio(
    BaseOptions(
      baseUrl: "https://student.valuxapps.com/api/",
      receiveDataWhenStatusError: true,
      headers: {
        "Content-Type": "application/json",
        "lang": "en",
      },
    ),
  );

  Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _dio.options.headers = {
      "Authorization": token,
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
    String? token,
  }) async {
    _dio.options.headers = {
      "Authorization": token,
    };
    return await _dio.post(
      path,
      queryParameters: query,
      data: data,
    );
  }
}
