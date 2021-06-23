import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final ApiRepository apiRepository;

  SettingBloc({required this.apiRepository})
      : super(SettingInitState());

  @override
  Stream<SettingState> mapEventToState(
    SettingEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
