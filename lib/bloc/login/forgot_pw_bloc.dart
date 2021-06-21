import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/widgets/validator.dart';

part 'forgot_pw_event.dart';
part 'forgot_pw_state.dart';

class ForgotPwBloc extends Bloc<ForgotPwEvent, ForgotPwState> {
  final ApiRepository apiRepository;
  ForgotPwBloc({required this.apiRepository}) : super(ForgotPwInitial());
  Timer? timer;
  int counter = 60;
  
  @override
  Stream<ForgotPwState> mapEventToState(
    ForgotPwEvent event,
  ) async* {
    if (event is SubmitEvent) {
      yield* checkIsValidAndSubmit(event.email, event.password, event.verificationCode);
    } else if (event is SendCodeStart) {
      yield CodeCountDownState(60);
      counter = 60;
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (counter <= 0) {
          timer.cancel();
          add(SendCodeAgain());
        } else {
          add(SendCodeTimer(--counter));
        }
      });
    } else if (event is SendCodeTimer) {
      yield CodeCountDownState(event.time);
    } else if (event is SendCodeAgain) {
      yield CodeSendState();
    }
    else {}
  }

  Stream<ForgotPwState> checkIsValidAndSubmit(String email, String password, String verificationCode) async* {
    if (email.isEmpty || !Validators.isValidEmail(email)) {
      yield EmailInvalidState();
    } else if (verificationCode.isEmpty) {
      yield VerificationCodeInvalidState();
    } else if (password.isEmpty) {
      yield PWInvalidState();
    }  else {
      //ToDo:  Register
      // yield ForgotPwFailedState(DateTime.now().millisecondsSinceEpoch);
      yield ForgotPwSuccessState();
    }
  }
}

class TimerTicked {
}
