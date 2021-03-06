import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:qfvpn/model/api/HttpErrorException.dart';
import 'package:qfvpn/model/api/bean/base_resp.dart';

import '../s.dart';

class ErrorCode {
  final BuildContext context;
  Map<String, String> errorTable = {};

  ErrorCode._(this.context) {
    errorTable = {
      'UserAlreadyExists': S.of(context).error_user_already_exists,
      'PointNotEnough': S.of(context).error_point_not_enough,
    };
  }

  static ErrorCode of(BuildContext context) => ErrorCode._(context);

  String getErrorMsgByCode(String errorCode) {
    return errorTable[errorCode] ?? S.of(context).error_unknown;
  }

  String getErrorMsg(dynamic resp) {
    if (resp is HttpErrorException) {
      return errorTable[resp.errorCode] ?? S.of(context).error_unknown;
    } else {
      return S.of(context).error_unknown;
    }
  }
}
