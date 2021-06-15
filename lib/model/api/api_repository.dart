import 'dart:convert';

import 'package:qfvpn/model/api/bean/login/login_req.dart';
import 'package:qfvpn/model/api/bean/login/login_resp.dart';

import 'api_result.dart';
import 'bean/base_resp.dart';
import 'logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

class ApiRepository {
  String baseUrl;
  Client httpClient = HttpClientWithInterceptor.build(
      interceptors: [LoggingInterceptor()],
      requestTimeout: Duration(seconds: 30));

  ApiRepository({required this.baseUrl});

  Future<ApiResult<BaseResp<LoginResp>>> login(LoginReq loginReq) async {
    try {
      final response = await httpClient.post(
          Uri.https(baseUrl, "/api/user/login"),
          headers: {
            "accept": "application/json",
            "Content-Type": "application/json"
          },
          body: json.encode(loginReq.toJson()));
      if (response.statusCode == 201) {
        return ApiResult.success(BaseResp.fromJson(json.decode(response.body),
            (json) => LoginResp.fromJson(json as Map<String, dynamic>)));
      } else {
        return ApiResult.error(Exception(response.body));
      }
    } catch (error) {
      return ApiResult.error(error);
    }
  }
}
