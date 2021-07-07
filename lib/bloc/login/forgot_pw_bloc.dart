import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/login/SendCodeReq.dart';
import 'package:qfvpn/model/api/bean/login/SendCodeResp.dart';
import 'package:qfvpn/model/api/bean/login/VerifyCodeReq.dart';
import 'package:qfvpn/widget/validator.dart';

part 'forgot_pw_event.dart';
part 'forgot_pw_state.dart';

class ForgotPwBloc extends Bloc<ForgotPwEvent, ForgotPwState> {
  final ApiRepository apiRepository;
  ForgotPwBloc({required this.apiRepository}) : super(ForgotPwInitial());
  Timer? timer;
  int counter = 60;

  String? verifyToken;

  @override
  Stream<ForgotPwState> mapEventToState(
    ForgotPwEvent event,
  ) async* {
    if (event is SubmitEvent) {
      yield* checkIsValidAndSubmit(event.email, event.password, event.verificationCode);
    } else if (event is SendCodeStart) {
      yield* sendCode(event.email);
    } else if (event is SendCodeTimer) {
      yield CodeCountDownState(event.time);
    } else if (event is SendCodeAgain) {
      yield CodeSendState();
    }
    else {}
  }

  Stream<ForgotPwState> sendCode(String email) async*{
    if (email.isEmpty || !Validators.isValidEmail(email)) {
      yield EmailInvalidState();
    } else {

      ApiResult result = await apiRepository.sendCode(SendCodeReq(email: email));
      if (result is Success) {
        verifyToken = result.data.token;
        yield CodeCountDownState(60);
        startTimer();
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
        yield ErrorState(result.error);
      }
    }
  }

  void startTimer() {
    counter = 60;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (counter <= 0) {
        timer.cancel();
        add(SendCodeAgain());
      } else {
        add(SendCodeTimer(--counter));
      }
    });
  }

  Stream<ForgotPwState> checkIsValidAndSubmit(String email, String password, String verificationCode) async* {
    if (email.isEmpty || !Validators.isValidEmail(email)) {
      yield EmailInvalidState();
    } else if (verificationCode.isEmpty || verificationCode.length != 6) {
      yield VerificationCodeInvalidState();
    } else if (password.isEmpty) {
      yield PWInvalidState();
    } else if (verifyToken == null) {
      yield NotSendCodeState();
    } else {
      ApiResult result = await apiRepository.verifyCode(VerifyCodeReq(code: verificationCode, token: verifyToken!));
      if (result is Success) {
        yield SuccessState();
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
        yield CodeVerifyFailState();
      }
    }
  }
}

class TimerTicked {
}
