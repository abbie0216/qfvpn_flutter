import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/widget/utils/app_utils.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  final ApiRepository apiRepository;
  AboutBloc({required this.apiRepository}) : super(AboutInitial());

  @override
  Stream<AboutState> mapEventToState(
    AboutEvent event,
  ) async* {
    if (event is AppVersionEvent) {
      yield* _appVersionEventToState();
    }

  }

  Stream<AboutState> _appVersionEventToState() async* {
    try {
      var version = await AppUtils.getAppVersion();
      Fimber.d('_appVersionEventToState: $version');

      yield AppVersionState(appVersion: version);
    }  catch (e) {
      Fimber.e('Error: $e');
    }
  }
}
