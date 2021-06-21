import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/api_repository.dart';

part 'forgot_pw_event.dart';
part 'forgot_pw_state.dart';

class ForgotPwBloc extends Bloc<ForgotPwEvent, ForgotPwState> {
  final ApiRepository apiRepository;
  ForgotPwBloc({required this.apiRepository}) : super(ForgotPwInitial());

  @override
  Stream<ForgotPwState> mapEventToState(
    ForgotPwEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
