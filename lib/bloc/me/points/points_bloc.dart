import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/points/PointsInfoResp.dart';
import 'package:qfvpn/model/api/bean/points/PrizeExchangeReq.dart';
import 'package:qfvpn/model/api/bean/points/PrizeListResp.dart';

part 'points_event.dart';

part 'points_state.dart';

class PointsBloc extends Bloc<PointsEvent, PointsState> {
  final ApiRepository apiRepository;

  PointsBloc({required this.apiRepository}) : super(PointsInitial());

  @override
  Stream<PointsState> mapEventToState(
    PointsEvent event,
  ) async* {
    if (event is FetchInfoEvent) {
      yield* fetchPointInfo();
    } else if (event is FetchPrizeListEvent) {
      yield* fetchPrizeList();
    } else if (event is PrizeExchangeEvent) {
      ApiResult result = await apiRepository.prizeExchange(PrizeExchangeReq(prizeId: event.prizeId));
      if (result is Success) {
        yield PrizeExchangeSuccess();
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
        yield PrizeExchangeFail(result.error);
      }
    } else if (event is CheckInEvent) {
      ApiResult result = await apiRepository.checkIn();
      if (result is Success) {
        yield* fetchPointInfo();
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
  }

  Stream<PointsInfoState> fetchPointInfo() async* {
    ApiResult result = await apiRepository.fetchPointsInfo();
    if (result is Success) {
      yield PointsInfoState(data: result.data);
    } else if (result is Error) {
      Fimber.d('error: ${result.error.toString()}');
    }
  }

  Stream<PrizeListState> fetchPrizeList() async* {
    ApiResult result = await apiRepository.fetchPrizeList();
    if (result is Success) {
      yield PrizeListState(data: result.data);
    } else if (result is Error) {
      Fimber.d('error: ${result.error.toString()}');
    }
  }
}
