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
      : super(LoginState(
            isEmailValid: false, isPasswordValid: false, showPassword: false));

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is ShowPasswordChanged) {
      yield state.copyWith(showPassword: !state.showPassword);
    } else {}
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.copyWith(isEmailValid: Validators.isValidEmail(email));
  }
}
