import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/login/login_req.dart';
import 'package:qfvpn/model/api/bean/login/register_req.dart';
import 'package:qfvpn/model/api/bean/login/register_resp.dart';
import 'package:qfvpn/model/api/bean/token.dart';
import 'package:qfvpn/model/pref.dart';

import '../../widget/validator.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ApiRepository apiRepository;
  RegisterBloc({required this.apiRepository})
      : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is SubmitEvent) {
      yield* checkIsValidAndSubmit(event.email, event.password, event.invitationCode);
    } else {}
  }


  Stream<RegisterState> checkIsValidAndSubmit(String email, String password, String? invitationCode) async* {
    if (email.isEmpty || !Validators.isValidEmail(email)) {
      yield RegisterEmailInvalidState();
    } else if (password.isEmpty) {
      yield RegisterPWEmptyState();
    } else if (password.length <= 6) {
      yield RegisterPWInvalidState();
    } else {
      ApiResult result = await apiRepository.register(RegisterReq(inviteCode: invitationCode?? '', email: email, password: password));
      if(result is Success) {
        RegisterResp resp = result.data;
        Fimber.d('resp: $resp');
        yield* login(email, password);
      } else if (result is Error){
        Fimber.d('error: ${result.error.toString()}');
        yield RegisterFailedState(result.error);
      }
    }
  }

  Stream<RegisterState> login(
      String email, String password) async* {
      ApiResult result = await apiRepository.login(LoginReq(email: email, password: password));
      if (result is Success) {
        Token token = result.data;
        Fimber.d('resp: $token');
        Pref().setupToken(token);
        yield LoginSuccessState();
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
        yield LoginFailedState(result.error);
      }
  }
}
