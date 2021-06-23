import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/widget/validator.dart';

part 'binding_event.dart';
part 'binding_state.dart';

class BindingBloc extends Bloc<BindingEvent, BindingState> {
  final ApiRepository apiRepository;

  BindingBloc({required this.apiRepository})
      : super(BindingInitState());

  @override
  Stream<BindingState> mapEventToState(
    BindingEvent event,
  ) async* {
    if (event is SubmitEvent) {
      yield* checkIsValidAndSubmit(event.email, event.password, event.invitationCode);
    } else {}
  }

  Stream<BindingState> checkIsValidAndSubmit(String email, String password, String? invitationCode) async* {
    if (email.isEmpty || !Validators.isValidEmail(email)) {
      yield BindingEmailInvalidState();
    } else if (password.isEmpty) {
      yield BindingPWInvalidState();
    } else {
      // yield BindingFailedState(DateTime.now().millisecondsSinceEpoch);
      yield BindingSuccessState();
    }
  }
}
