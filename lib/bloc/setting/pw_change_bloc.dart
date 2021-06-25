import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';

part 'pw_change_event.dart';
part 'pw_change_state.dart';

class PwChangeBloc extends Bloc<PwChangeEvent, PwChangeState> {
  final ApiRepository apiRepository;

  PwChangeBloc({required this.apiRepository})
      : super(PwChangeInitState());

  @override
  Stream<PwChangeState> mapEventToState(
    PwChangeEvent event,
  ) async* {
    if (event is SubmitEvent) {
      yield* checkIsValidAndSubmit(event.orgPassword, event.newPassword);
    } else {}
  }

  Stream<PwChangeState> checkIsValidAndSubmit(String orgPassword, String newPassword) async* {
    if (orgPassword.isEmpty) {
      yield OrgPWInvalidState();
    } else if (newPassword.isEmpty) {
      yield NewPWInvalidState();
    } else {
      // yield PwChangeFailedState(DateTime.now().millisecondsSinceEpoch);
      yield PwChangeSuccessState();
    }
  }
}
