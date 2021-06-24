import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';

part 'me_event.dart';
part 'me_state.dart';

class MeBloc extends Bloc<MeEvent, MeState> {
  final ApiRepository apiRepository;

  MeBloc({required this.apiRepository}) : super(MeInitState());

  @override
  Stream<MeState> mapEventToState(
    MeEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
