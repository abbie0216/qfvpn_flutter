import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/bean/feedback/category_list_resp.dart';
import 'package:qfvpn/model/api/bean/feedback/create_feedback_req.dart';
import 'package:qfvpn/model/api/bean/feedback/detail_req.dart';
import 'package:qfvpn/model/api/bean/feedback/detail_resp.dart';
import 'package:qfvpn/model/api/bean/feedback/take_survey_req.dart';
import 'package:qfvpn/model/api/bean/invite/invite_info_resp.dart';
import 'package:qfvpn/model/api/bean/invite/invite_list_resp.dart';
import 'package:qfvpn/model/api/bean/login/ChangePasswordReq.dart';
import 'package:qfvpn/model/api/bean/login/RefreshTokenReq.dart';
import 'package:qfvpn/model/api/bean/login/SendCodeReq.dart';
import 'package:qfvpn/model/api/bean/login/login_req.dart';
import 'package:qfvpn/model/api/bean/node/node_list_resp.dart';
import 'package:qfvpn/model/api/bean/paging.dart';
import 'package:qfvpn/model/api/bean/points/PointsInfoResp.dart';
import 'package:qfvpn/model/api/bean/points/PrizeExchangeReq.dart';
import 'package:qfvpn/model/api/bean/product/product_list_resp.dart';
import 'package:qfvpn/model/api/bean/splash/version_req.dart';
import 'package:qfvpn/model/api/bean/token.dart';
import 'package:qfvpn/model/api/bean/user/UserCouponListResp.dart';
import 'package:qfvpn/model/api/generate_api_result.dart';

import '../pref.dart';
import 'api_result.dart';
import 'bean/feedback/create_reply_req.dart';
import 'bean/feedback/feedback_list_resp.dart';
import 'bean/feedback/upload_attachment_resp.dart';
import 'bean/login/RefreshTokenResp.dart';
import 'bean/login/ResetPasswordReq.dart';
import 'bean/login/SendCodeResp.dart';
import 'bean/login/VerifyCodeReq.dart';
import 'bean/login/register_req.dart';
import 'bean/login/register_resp.dart';
import 'bean/order/order_detail_req.dart';
import 'bean/order/order_detail_resp.dart';
import 'bean/order/orders_list_resp.dart';
import 'bean/points/PointsDetailResp.dart';
import 'bean/points/PointsInfoResp.dart';
import 'bean/points/PrizeListResp.dart';
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

    dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true));
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

  Future<ApiResult<UserCouponListResp>> fetchUserCouponList(Paging req) async {
    return GenerateApiResult.from<UserCouponListResp>(
      apiCall: () async {
        return await _dio.post('/api/coupon/userCouponList',
            data: json.encode(req.toJson()));
      },
      parseSuccessData: (response) {
        return UserCouponListResp.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<NodeListResp>> fetchNodeList() async {
    return GenerateApiResult.from<NodeListResp>(
      apiCall: () async {
        return await _dio.post('/api/node/list');
      },
      parseSuccessData: (response) {
        return NodeListResp.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<ProductListResp>> fetchProductList() async {
    return GenerateApiResult.from<ProductListResp>(
      apiCall: () async {
        return await _dio.post('/api/product/list');
      },
      parseSuccessData: (response) {
        return ProductListResp.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<CategoryListResp>> fetchCategoryList() async {
    return GenerateApiResult.from<CategoryListResp>(
      apiCall: () async {
        return await _dio.post('/api/feedback/categoryList');
      },
      parseSuccessData: (response) {
        return CategoryListResp.fromJson(response.data['data']);
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

  Future<ApiResult<DetailResp>> fetchFeedbackDetail(DetailReq detailReq) async {
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

  Future<ApiResult<void>> createFeedback(CreateFeedbackReq req) async {
    return GenerateApiResult.from<void>(
      apiCall: () async {
        return await _dio.post('/api/feedback/create',
            data: json.encode(req.toJson()));
      },
      parseSuccessData: (response) {
        return null;
      },
    );
  }

  Future<ApiResult<UploadAttachmentResp>> uploadAttachment(String filePath,
      {bool isReply = false}) async {
    _dio.options.headers['Content-Type'] = 'multipart/form-data';
    var formData =
        FormData.fromMap({'file': await MultipartFile.fromFile(filePath)});
    var path = isReply
        ? '/api/feedbackReply/uploadAttachment'
        : '/api/feedback/uploadAttachment';
    try {
      var response = await _dio.post(path, data: formData);
      return ApiResult.success(
          UploadAttachmentResp.fromJson(response.data['data']));
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    } finally {
      _dio.options.headers['Content-Type'] = 'application/json';
    }
  }

  Future<ApiResult<void>> takeSurvey(TakeSurveyReq req) async {
    return GenerateApiResult.from<void>(
      apiCall: () async {
        return await _dio.post('/api/feedback/takeSurvey',
            data: json.encode(req.toJson()));
      },
      parseSuccessData: (response) {
        return null;
      },
    );
  }

  Future<ApiResult<void>> createReply(CreateReplyReq req) async {
    return GenerateApiResult.from<void>(
      apiCall: () async {
        return await _dio.post('/api/feedbackReply/create',
            data: json.encode(req.toJson()));
      },
      parseSuccessData: (response) {
        return null;
      },
    );
  }

  Future<ApiResult<OrdersListResp>> fetchOrdersList(Paging paging) async {
    return GenerateApiResult.from<OrdersListResp>(apiCall: () async {
      return await _dio.post('/api/order/list',
          data: json.encode(paging.toJson()));
    }, parseSuccessData: (response) {
      return OrdersListResp.fromJson(response.data['data']);
    });
  }

  Future<ApiResult<OrderDetailResp>> fetchOrderDetail(
      OrderDetailReq req) async {
    return GenerateApiResult.from<OrderDetailResp>(apiCall: () async {
      return await _dio.post('/api/order/detail',
          data: json.encode(req.toJson()));
    }, parseSuccessData: (response) {
      return OrderDetailResp.fromJson(response.data['data']);
    });
  }

  Future<ApiResult<InviteInfoResp>> fetchInviteInfo() async {
    return GenerateApiResult.from<InviteInfoResp>(
      apiCall: () async {
        return await _dio.post('/api/invite/info');
      },
      parseSuccessData: (response) {
        return InviteInfoResp.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<InviteListResp>> fetchInviteList(Paging paging) async {
    return GenerateApiResult.from<InviteListResp>(
      apiCall: () async {
        return await _dio.post('/api/invite/list',
            data: json.encode(paging.toJson()));
      },
      parseSuccessData: (response) {
        return InviteListResp.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<PointsInfoResp>> fetchPointsInfo() async {
    return GenerateApiResult.from<PointsInfoResp>(
      apiCall: () async {
        return await _dio.post('/api/point/info');
      },
      parseSuccessData: (response) {
        return PointsInfoResp.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<PrizeListResp>> fetchPrizeList() async {
    return GenerateApiResult.from<PrizeListResp>(
      apiCall: () async {
        return await _dio.post('/api/point/prizeList');
      },
      parseSuccessData: (response) {
        return PrizeListResp.fromJson(response.data['data']);
      },
    );
  }

  Future<ApiResult<bool>> prizeExchange(PrizeExchangeReq req) async {
    return GenerateApiResult.from<bool>(
      apiCall: () async {
        return await _dio.post('/api/point/prizeExchange',
            data: json.encode(req.toJson()));
      },
      parseSuccessData: (response) {
        return true;
      },
    );
  }

  Future<ApiResult<bool>> checkIn() async {
    return GenerateApiResult.from<bool>(
      apiCall: () async {
        return await _dio.post('/api/point/task/signin');
      },
      parseSuccessData: (response) {
        return true;
      },
    );
  }

  Future<ApiResult<PointsDetailResp>> fetchPointsDetails(Paging req) async {
    return GenerateApiResult.from<PointsDetailResp>(
      apiCall: () async {
        return await _dio.post('/api/point/transList',
            data: json.encode(req.toJson()));
      },
      parseSuccessData: (response) {
        return PointsDetailResp.fromJson(response.data['data']);
      },
    );
  }
}
