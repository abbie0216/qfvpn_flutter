import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';
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
