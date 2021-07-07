import 'dart:convert';

import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/bean/login/RefreshTokenReq.dart';
import 'package:qfvpn/model/api/bean/login/login_req.dart';
import 'package:qfvpn/model/api/bean/node/node_list_result.dart';
import 'package:qfvpn/model/api/bean/token.dart';

import '../pref.dart';
import 'api_result.dart';
import 'bean/login/RefreshTokenResp.dart';
import 'bean/login/register_req.dart';
import 'bean/login/register_resp.dart';
import 'package:dio/dio.dart';

import 'bean/splash/version_resp.dart';

class ApiRepository {
  late final String _baseUrl;
  late Dio _dio;
  late Pref _pref;

  ApiRepository(this._baseUrl) {
    _dio = _baseDio();
    _pref = Pref();
  }

  Dio _baseDio() {
    var dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 100000,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
    ));

    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        var token = await _pref.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer ${token.accessToken}';
        }
        Fimber.d('headers: ${options.headers}');
        Fimber.d('uri: ${options.uri}');
        Fimber.d('data: ${options.data}');
        Fimber.d('query: ${options.queryParameters}');
        return handler.next(options);
      },
        // for test change domain
      onError: (error, handler) async {
        if(error.message.contains('SocketException')) {
          var options = error.requestOptions;
          options.baseUrl = 'https://qfvpn.com';
          options.headers = {
            'accept': 'application/json',
            'Content-Type': 'application/json'};
          Fimber.d('@@ url = ${options.baseUrl}, ${options.uri}');
          dio.options.baseUrl = options.baseUrl;
          dio.options.headers = {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          };
          dio.options.method = options.method;
          var response = await dio.request(options.path);
          handler.resolve(response);
        } else {
          handler.next(error);
        }
      }
    ));
    return dio;
  }

  Future<ApiResult<RegisterResp>> register(RegisterReq req) async {
    try {
      final response =
          await _dio.post('/api/user/signup', data: json.encode(req.toJson()));
      if (response.statusCode == 201) {
        return ApiResult.success(RegisterResp.fromJson(response.data['data']));
      } else {
        return ApiResult.error(response);
      }
    } catch (error) {
      return ApiResult.error(error);
    }
  }

  Future<ApiResult<Token>> login(LoginReq loginReq) async {
    try {
      final response = await _dio.post('/api/user/login',
          data: json.encode(loginReq.toJson()));

      Fimber.d('response: ' + response.toString());
      Fimber.d('status code: ' + response.statusCode.toString());

      if (response.statusCode == 201) {
        return ApiResult.success(Token.fromJson(response.data['data']));
      } else {
        Fimber.d('error: ' + response.data['errCode']);
        return ApiResult.error(response);
      }
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    }
  }

  Future<ApiResult<VersionResp>> checkVersion() async {
    try{
      final response = await _dio.post('/api/version/check');

      Fimber.d('response: ' + response.toString());
      Fimber.d('status code: ' + response.statusCode.toString());

      if (response.statusCode == 201) {
        return ApiResult.success(VersionResp.fromJson(response.data['data']));
      } else {
        Fimber.d('error: ' + response.data['errCode']);
        return ApiResult.error(response);
      }
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    }
  }

  Future<ApiResult<RefreshTokenResp>> refreshToken(RefreshTokenReq req) async {
    try {
      final response = await _dio.post('/api/user/refreshToken',
          data: json.encode(req.toJson()));

      Fimber.d('response: ' + response.toString());
      Fimber.d('status code: ' + response.statusCode.toString());

      if (response.statusCode == 201) {
        return ApiResult.success(RefreshTokenResp.fromJson(response.data['data']));
      } else {
        Fimber.d('error: ' + response.data['errCode']);
        return ApiResult.error(response);
      }
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    }
  }

  Future<ApiResult<NodeListResult>> fetchNodeList() async {
    try {
      final response = await _dio.post('/api/node/list');

      Fimber.d('response: ' + response.toString());
      Fimber.d('status code: ' + response.statusCode.toString());
      if (response.statusCode == 201) {
        return ApiResult.success(NodeListResult.fromJson(response.data['data']));
      } else {
        Fimber.d('error: ' + response.data['errCode']);
        return ApiResult.error(response);
      }
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    }
  }

}
