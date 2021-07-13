import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/paging.dart';
import 'package:qfvpn/model/api/bean/points/PointsDetailResp.dart';

import '../../../constants.dart';

part 'points_detail_event.dart';
part 'points_detail_state.dart';

class PointsDetailBloc extends Bloc<PointsDetailEvent, PointsDetailState> {
  final ApiRepository apiRepository;
  PointsDetailBloc({required this.apiRepository}) : super(PointsDetailInitial());

  @override
  Stream<PointsDetailState> mapEventToState(
    PointsDetailEvent event,
  ) async* {
    if (event is FetchListEvent) {
      ApiResult result = await apiRepository
          .fetchPointsDetails(Paging(pageNo: event.pageNo, pageSize: PAGE_SIZE));
      if (result is Success) {
        yield ListLoadedState(result.data);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
  }
}
