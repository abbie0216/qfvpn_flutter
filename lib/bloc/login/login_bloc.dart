import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';

import '../../validator.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiRepository apiRepository;

  LoginBloc({required this.apiRepository})
      : super(LoginInitState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    debugPrint('get SubmitEvent');
    if (event is SubmitEvent) {
      yield* checkIsValidAndSubmit(event.email, event.password);
    } else {}
  }

  Stream<LoginState> checkIsValidAndSubmit(String email, String password) async* {
    if (email.isEmpty || !Validators.isValidEmail(email)) {
      yield LoginEmailInvalidState();
    } else if (password.isEmpty) {
      yield LoginPWInvalidState();
    } else {
      //ToDo:  login
      // yield LoginFailedState(DateTime.now().millisecondsSinceEpoch);
      yield LoginSuccessState();
    }
  }
}
