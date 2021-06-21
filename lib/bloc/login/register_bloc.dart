import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';

import '../../validator.dart';

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
      yield RegisterPWInvalidState();
    } else {
      //ToDo:  Register
      // yield RegisterFailedState(DateTime.now().millisecondsSinceEpoch);
      yield RegisterSuccessState();
    }
  }
}
