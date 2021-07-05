
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:qfvpn/model/api/bean/base_resp.dart';

import '../s.dart';

class ErrorCode {
  final BuildContext context;
  Map<String, String> errorTable = {};
  ErrorCode._(this.context) {
     errorTable = {
      'UserAlreadyExists': S.of(context).error_user_already_exists,
    };
  }

  static ErrorCode of(BuildContext context) => ErrorCode._(context);

  String getErrorMsgByCode(String errorCode) {
    return errorTable[errorCode] ?? S.of(context).error_unknown;
  }

  String getErrorMsg(dynamic resp) {
    if (resp is Response) {
        return errorTable[resp.data['errCode']] ?? S.of(context).error_unknown;
    } else {
      return S.of(context).error_unknown;
    }
  }


}