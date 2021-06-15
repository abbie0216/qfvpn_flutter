import 'dart:convert';

import 'package:qfvpn/model/api/bean/login/login.req.dart';

import 'api_result.dart';
import 'logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

class ApiRepository {
  String baseUrl;
  Client httpClient = HttpClientWithInterceptor.build(
      interceptors: [LoggingInterceptor()],
      requestTimeout: Duration(seconds: 30));

  ApiRepository({required this.baseUrl});

  Future<ApiResult<String>> login(LoginReq loginReq) async {
    try {
      final response = await httpClient.post(
        Uri.https(baseUrl, "/api/user/login"),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json"
        },
        body: json.encode(loginReq.toJson())
      );
      if (response.statusCode == 200) {
        return ApiResult.success(response.body);
      } else {
        return ApiResult.error(Exception(response.body));
      }
    } catch (error) {
      return ApiResult.error(error);
    }
  }
}
