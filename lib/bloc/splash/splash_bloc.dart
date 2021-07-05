import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/base_resp.dart';
import 'package:qfvpn/model/api/bean/login/login_req.dart';
import 'package:qfvpn/model/api/bean/token.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final ApiRepository apiRepository;

  SplashBloc({required this.apiRepository}) : super(SplashInitState());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if(event is SplashFetchEvent) {
      // ApiResult result = await apiRepository.login(LoginReq("sion.wang@silkrode.com.tw", "aa123456"));
      // if(result is Success) {
      //   LoginResp resp = (result.data as BaseResp).data;
      //   debugPrint('resp: $resp');
      // }
      await Future.delayed(const Duration(seconds: 2), (){});
      yield SplashLoadedState();
    } else {

    }
  }

}