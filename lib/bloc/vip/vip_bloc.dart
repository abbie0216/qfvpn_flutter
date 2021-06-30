import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/api_repository.dart';

part 'vip_event.dart';
part 'vip_state.dart';

class VipBloc extends Bloc<VipEvent, VipState> {
  final ApiRepository apiRepository;

  VipBloc({required this.apiRepository}) : super(VipInitial());

  @override
  Stream<VipState> mapEventToState(
    VipEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
