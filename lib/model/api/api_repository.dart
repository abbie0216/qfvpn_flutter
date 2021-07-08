import 'dart:convert';
import 'dart:io';

import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/HttpErrorException.dart';
import 'package:qfvpn/model/api/bean/login/ChangePasswordReq.dart';
import 'package:qfvpn/model/api/bean/login/RefreshTokenReq.dart';
import 'package:qfvpn/model/api/bean/login/SendCodeReq.dart';
import 'package:qfvpn/model/api/bean/login/login_req.dart';
import 'package:qfvpn/model/api/bean/node/node_list_result.dart';
import 'package:qfvpn/model/api/bean/splash/version_req.dart';
import 'package:qfvpn/model/api/bean/product/product_list_result.dart';
import 'package:qfvpn/model/api/bean/token.dart';

import '../pref.dart';
import 'api_result.dart';
import 'bean/login/RefreshTokenResp.dart';
import 'bean/login/ResetPasswordReq.dart';
import 'bean/login/SendCodeResp.dart';
import 'bean/login/VerifyCodeReq.dart';
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
          dio.options.baseUrl = 'https://qfvpn.com';
          dio.options.headers = {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          };
          dio.options.queryParameters = error.requestOptions.queryParameters;
          dio.options.method = error.requestOptions.method;
          var response = await dio.request(error.requestOptions.path, data: error.requestOptions.data);
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
        return ApiResult.error(HttpErrorException(errorCode: response.data['errCode'], errorMsg: response.data['errMsg']));
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
        Fimber.d('error: ' + response.data['errMsg']);
        return ApiResult.error(HttpErrorException(errorCode: response.data['errCode'], errorMsg: response.data['errMsg']));
      }
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    }
  }

  Future<ApiResult<VersionResp>> checkVersion() async {
    try {
      var platform;
      if(Platform.isAndroid) {
        platform = 'Android';
      } else {
        platform = 'iOS';
      }

      final response = await _dio.post('/api/version/check',
      data: json.encode(VersionReq(platform: platform)));

      Fimber.d('response: ' + response.toString());
      Fimber.d('status code: ' + response.statusCode.toString());

      if (response.statusCode == 201) {
        return ApiResult.success(VersionResp.fromJson(response.data['data']));
      } else {
        Fimber.d('error: ' + response.data['errCode']);
        return ApiResult.error(HttpErrorException(errorCode: response.data['errCode'], errorMsg: response.data['errMsg']));
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
        return ApiResult.success(
            RefreshTokenResp.fromJson(response.data['data']));
      } else {
        Fimber.d('error: ' + response.data['errMsg']);
        return ApiResult.error(HttpErrorException(errorCode: response.data['errCode'], errorMsg: response.data['errMsg']));
      }
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    }
  }

  Future<ApiResult<SendCodeResp>> sendCode(SendCodeReq req) async {
    try {
      final response = await _dio.post('/api/user/resetPassword/sendCode',
          data: json.encode(req.toJson()));

      Fimber.d('response: ' + response.toString());
      Fimber.d('status code: ' + response.statusCode.toString());

      if (response.statusCode == 201) {
        return ApiResult.success(SendCodeResp.fromJson(response.data['data']));
      } else {
        Fimber.d('error: ' + response.data['errMsg']);
        return ApiResult.error(HttpErrorException(errorCode: response.data['errCode'], errorMsg: response.data['errMsg']));
      }
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    }
  }

  Future<ApiResult<bool>> verifyCode(VerifyCodeReq req) async {
    try {
      final response = await _dio.post('/api/user/resetPassword/verifyCode',
          data: json.encode(req.toJson()));

      Fimber.d('response: ' + response.toString());
      Fimber.d('status code: ' + response.statusCode.toString());

      if (response.statusCode == 201) {
        return ApiResult.success(true);
      } else {
        Fimber.d('error: ' + response.data['errMsg']);
        return ApiResult.error(HttpErrorException(errorCode: response.data['errCode'], errorMsg: response.data['errMsg']));
      }
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    }
  }

  Future<ApiResult<bool>> resetPassword(ResetPasswordReq req) async {
    try {
      final response = await _dio.post('/api/user/resetPassword',
          data: json.encode(req.toJson()));

      Fimber.d('response: ' + response.toString());
      Fimber.d('status code: ' + response.statusCode.toString());

      if (response.statusCode == 201) {
        return ApiResult.success(true);
      } else {
        Fimber.d('error: ' + response.data['errMsg']);
        return ApiResult.error(HttpErrorException(errorCode: response.data['errCode'], errorMsg: response.data['errMsg']));
      }
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    }
  }

  Future<ApiResult<bool>> changePassword(ChangePasswordReq req) async {
    try {
      final response = await _dio.post('/api/user/changePassword',
          data: json.encode(req.toJson()));

      Fimber.d('response: ' + response.toString());
      Fimber.d('status code: ' + response.statusCode.toString());

      if (response.statusCode == 201) {
        return ApiResult.success(true);
      } else {
        Fimber.d('error: ' + response.data['errMsg']);
        return ApiResult.error(HttpErrorException(errorCode: response.data['errCode'], errorMsg: response.data['errMsg']));
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
        return ApiResult.success(
            NodeListResult.fromJson(response.data['data']));
      } else {
        Fimber.d('error: ' + response.data['errCode']);
        return ApiResult.error(response);
      }
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    }
  }

  Future<ApiResult<ProductListResult>> fetchProductList() async {
    try {
      final response = await _dio.post('/api/product/list');

      Fimber.d('response: ' + response.toString());
      Fimber.d('status code: ' + response.statusCode.toString());
      if (response.statusCode == 201) {
        return ApiResult.success(
            ProductListResult.fromJson(response.data['data']));
      } else {
        Fimber.d('error: ' + response.data['errCode']);
        return ApiResult.error(HttpErrorException(errorCode: response.data['errCode'], errorMsg: response.data['errMsg']));
      }
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    }
  }

}
