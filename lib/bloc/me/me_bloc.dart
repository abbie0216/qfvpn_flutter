import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/user/User.dart';
import 'package:qfvpn/widget/utils/app_utils.dart';

part 'me_event.dart';

part 'me_state.dart';

class MeBloc extends Bloc<MeEvent, MeState> {
  final ApiRepository apiRepository;

  MeBloc({required this.apiRepository}) : super(MeInitState());

  @override
  Stream<MeState> mapEventToState(
    MeEvent event,
  ) async* {
    if (event is AppVersionEvent) {
      yield* _appVersionEventToState();
    } else if (event is GetUserInfoEvent) {
      yield* _getUserInfo();
    }
  }

  Stream<MeState> _getUserInfo() async* {
      ApiResult result = await apiRepository.getUserInfo();
      if (result is Success) {
        yield UserInfoUpdatedState(result.data);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
        yield ErrorState(result.error);
      }
  }

  Stream<MeState> _appVersionEventToState() async* {
    try {
      var version = await AppUtils.getAppVersion();
      Fimber.d('_appVersionEventToState: $version');

      yield AppVersionState(appVersion: version);
    } catch (e) {
      Fimber.e('Error: $e');
    }
  }
}
