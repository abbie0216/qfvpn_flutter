import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/api_repository.dart';

part 'points_detail_event.dart';
part 'points_detail_state.dart';

class PointsDetailBloc extends Bloc<PointsDetailEvent, PointsDetailState> {
  final ApiRepository apiRepository;
  PointsDetailBloc({required this.apiRepository}) : super(PointsDetailInitial());

  @override
  Stream<PointsDetailState> mapEventToState(
    PointsDetailEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
