import 'package:dio/dio.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

import 'HttpErrorException.dart';
import 'api_result.dart';

class GenerateApiResult<T> {
  late final Future<Response<dynamic>> Function() apiCall;
  late final T Function(Response<dynamic> response) parseSuccessData;

  static Future<ApiResult<T>> from<T>({required apiCall, required parseSuccessData}) async{
    try {
      final response = await apiCall.call();

      Fimber.d('response: ' + response.toString());
      Fimber.d('status code: ' + response.statusCode.toString());

      if (response.statusCode == 201) {
        return ApiResult.success(parseSuccessData.call(response));
      } else {
        Fimber.d('error: ' + response.data['errMsg']);
        return ApiResult.error(HttpErrorException(
            errorCode: response.data['errCode'],
            errorMsg: response.data['errMsg']));
      }
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    }
  }

  Future<ApiResult<T>> get() async {
    try {
      final response = await apiCall.call();

      Fimber.d('response: ' + response.toString());
      Fimber.d('status code: ' + response.statusCode.toString());

      if (response.statusCode == 201) {
        return ApiResult.success(parseSuccessData.call(response));
      } else {
        Fimber.d('error: ' + response.data['errMsg']);
        return ApiResult.error(HttpErrorException(
            errorCode: response.data['errCode'],
            errorMsg: response.data['errMsg']));
      }
    } catch (error) {
      Fimber.d('error: ' + error.toString());
      return ApiResult.error(error);
    }
  }
}
