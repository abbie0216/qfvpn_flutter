import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/bean/feedback/detail_req.dart';
import 'package:qfvpn/model/api/bean/feedback/detail_resp.dart';
import 'package:qfvpn/model/api/bean/feedback/paging.dart';
import 'package:qfvpn/model/api/bean/login/ChangePasswordReq.dart';
import 'package:qfvpn/model/api/bean/login/RefreshTokenReq.dart';
import 'package:qfvpn/model/api/bean/login/SendCodeReq.dart';
import 'package:qfvpn/model/api/bean/login/login_req.dart';
import 'package:qfvpn/model/api/bean/node/node_list_result.dart';
import 'package:qfvpn/model/api/bean/splash/version_req.dart';
import 'package:qfvpn/model/api/bean/product/product_list_result.dart';
import 'package:qfvpn/model/api/bean/token.dart';
import 'package:qfvpn/model/api/generate_api_result.dart';

import '../pref.dart';
import 'api_result.dart';
import 'bean/feedback/feedback_list_resp.dart';
import 'bean/login/RefreshTokenResp.dart';
import 'bean/login/ResetPasswordReq.dart';
import 'bean/login/SendCodeResp.dart';
import 'bean/login/VerifyCodeReq.dart';
import 'bean/login/register_req.dart';
import 'bean/login/register_resp.dart';
import 'bean/splash/version_resp.dart';
import 'bean/user/User.dart';

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
        if (error.message.contains('SocketException')) {
          dio.options.baseUrl = 'https://qfvpn.com';
          dio.options.headers = {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          };
          dio.options.queryParameters = error.requestOptions.queryParameters;
          dio.options.method = error.requestOptions.method;
          var response = await dio.request(error.requestOptions.path,
              data: error.requestOptions.data);
          handler.resolve(response);
        } else {
          handler.next(error);
        }
      },
    ));
    return dio;
  }

  Future<ApiResult<RegisterResp>> register(RegisterReq req) async {
    return GenerateApiResult.from<RegisterResp>(
      apiCall: () async {
        return await _dio.post('/api/user/signup',
            data: json.encode(req.toJson()));
      },
      parseSuccessData: (response) {
        return RegisterResp.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<Token>> login(LoginReq loginReq) async {
    return GenerateApiResult.from<Token>(
      apiCall: () async {
        return await _dio.post('/api/user/login',
            data: json.encode(loginReq.toJson()));
      },
      parseSuccessData: (response) {
        return Token.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<VersionResp>> checkVersion() async {
    var platform;
    if (Platform.isAndroid) {
      platform = 'Android';
    } else {
      platform = 'iOS';
    }
    return GenerateApiResult.from<VersionResp>(
      apiCall: () async {
        return await _dio.post('/api/version/check',
            data: VersionReq(platform: platform).toJson());
      },
      parseSuccessData: (response) {
        return VersionResp.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<RefreshTokenResp>> refreshToken(RefreshTokenReq req) async {
    return GenerateApiResult.from<RefreshTokenResp>(
      apiCall: () async {
        return await _dio.post('/api/user/refreshToken',
            data: json.encode(req.toJson()));
      },
      parseSuccessData: (response) {
        return RefreshTokenResp.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<SendCodeResp>> sendCode(SendCodeReq req) async {
    return GenerateApiResult.from<SendCodeResp>(
      apiCall: () async {
        return await _dio.post('/api/user/resetPassword/sendCode',
            data: json.encode(req.toJson()));
      },
      parseSuccessData: (response) {
        return SendCodeResp.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<bool>> verifyCode(VerifyCodeReq req) async {
    return GenerateApiResult.from<bool>(
      apiCall: () async {
        return await _dio.post('/api/user/resetPassword/verifyCode',
            data: json.encode(req.toJson()));
      },
      parseSuccessData: (response) {
        return true;
      },
    );
  }

  Future<ApiResult<bool>> resetPassword(ResetPasswordReq req) async {
    return GenerateApiResult.from<bool>(
      apiCall: () async {
        return _dio.post('/api/user/resetPassword',
            data: json.encode(req.toJson()));
      },
      parseSuccessData: (response) {
        return true;
      },
    );
  }

  Future<ApiResult<bool>> changePassword(ChangePasswordReq req) async {
    return GenerateApiResult.from<bool>(
      apiCall: () async {
        return await _dio.post('/api/user/changePassword',
            data: json.encode(req.toJson()));
      },
      parseSuccessData: (response) {
        return true;
      },
    );
  }

  Future<ApiResult<User>> getUserInfo() async {
    return GenerateApiResult.from<User>(
      apiCall: () async {
        return await _dio.post('/api/user/info');
      },
      parseSuccessData: (response) {
        return User.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<NodeListResult>> fetchNodeList() async {
    return GenerateApiResult.from<NodeListResult>(
      apiCall: () async {
        return await _dio.post('/api/node/list');
      },
      parseSuccessData: (response) {
        return NodeListResult.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<ProductListResult>> fetchProductList() async {
    return GenerateApiResult.from<ProductListResult>(
      apiCall: () async {
        return await _dio.post('/api/product/list');
      },
      parseSuccessData: (response) {
        return ProductListResult.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<FeedbackListResp>> fetchFeedbackList(Paging paging) async {
    return GenerateApiResult.from<FeedbackListResp>(
      apiCall: () async {
        return await _dio.post('/api/feedback/list',
            data: json.encode(paging.toJson()));
      },
      parseSuccessData: (response) {
        return FeedbackListResp.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<DetailResp>> fetchFeedbackDetail(DetailReq detailReq ) async {
    return GenerateApiResult.from<DetailResp>(
      apiCall: () async {
        return await _dio.post('/api/feedback/detail',
            data: json.encode(detailReq.toJson()));
      },
      parseSuccessData: (response) {
        return DetailResp.fromJson(response.data['data']);
      },
    );
  }
}
