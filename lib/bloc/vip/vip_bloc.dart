import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/user/User.dart';

part 'vip_event.dart';
part 'vip_state.dart';

class VipBloc extends Bloc<VipEvent, VipState> {
  final ApiRepository apiRepository;

  VipBloc({required this.apiRepository}) : super(InitState());

  @override
  Stream<VipState> mapEventToState(
    VipEvent event,
  ) async* {
    if (event is GetUserInfoEvent) {
      ApiResult result = await apiRepository.getUserInfo();
      if (result is Success) {
        yield UserInfoUpdatedState(result.data);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
        yield ErrorState(result.error);
      }
    }
  }

}
