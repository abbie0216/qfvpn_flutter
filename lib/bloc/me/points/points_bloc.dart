import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';

part 'points_event.dart';
part 'points_state.dart';

class PointsBloc extends Bloc<PointsEvent, PointsState> {
  final ApiRepository apiRepository;
  PointsBloc({required this.apiRepository}) : super(PointsInitial());

  @override
  Stream<PointsState> mapEventToState(
    PointsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
