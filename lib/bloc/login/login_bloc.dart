import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/base_resp.dart';
import 'package:qfvpn/model/api/bean/login/login_req.dart';
import 'package:qfvpn/model/api/bean/token.dart';
import 'package:qfvpn/model/pref.dart';

import '../../widget/validator.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiRepository apiRepository;

  LoginBloc({required this.apiRepository}) : super(LoginInitState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SubmitEvent) {
      yield* checkIsValidAndSubmit(event.email, event.password);
    } else {}
  }

  Stream<LoginState> checkIsValidAndSubmit(
      String email, String password) async* {
    if (email.isEmpty || !Validators.isValidEmail(email)) {
      yield LoginEmailInvalidState();
    } else if (password.isEmpty) {
      yield LoginPWInvalidState();
    } else {
      ApiResult result = await apiRepository.login(LoginReq(email: email, password: password));
      if (result is Success) {
        Token token = result.data;
        Fimber.d('resp: ${token.toString()}');
        Pref().setupToken(token);
        yield LoginSuccessState(DateTime.now().millisecondsSinceEpoch);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
        yield LoginFailedState(
            DateTime.now().millisecondsSinceEpoch, result.error);
      }
      // yield LoginFailedState(DateTime.now().millisecondsSinceEpoch);
      // yield LoginSuccessState();
    }
  }
}
