import 'package:dio/dio.dart';
import 'package:tracitan_challenge_development/core/network/api_response.dart';

class ApiClient{
  final Dio _dio = Dio();

  static ApiClient? _instance;

  static getInstance() {
    _instance ??= ApiClient();
    return _instance!;
  }

    Future<ApiResponse<List<Map<String, dynamic>>>> get(
    String path) async {
    var response = await _dio.get(
      path,
    );

    return ApiResponse(
        response.statusCode,
        response.statusCode == 500
            ? null
            : (response.data is List<Map<String, dynamic>>)
                ? response.data
                : {});
  }


}