import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/login/login.req.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final ApiRepository apiRepository;

  SplashBloc({required this.apiRepository}) : super(SplashInitState());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if(event is SplashFetchEvent) {
      ApiResult result = await apiRepository.login(LoginReq("sion.wang@silkrode.com.tw", "aa123456"));
      yield SplashLoadedState();
    } else {

    }
  }

}