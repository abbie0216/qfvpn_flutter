import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/order/order_detail_req.dart';
import 'package:qfvpn/model/api/bean/order/order_detail_resp.dart';

part 'order_history_detail_event.dart';
part 'order_history_detail_state.dart';

class OrderHistoryDetailBloc extends Bloc<OrderHistoryDetailEvent, OrderHistoryDetailState> {
  final ApiRepository apiRepository;
  OrderHistoryDetailBloc({required this.apiRepository}) : super(OrderHistoryDetailInitial());

  @override
  Stream<OrderHistoryDetailState> mapEventToState(
    OrderHistoryDetailEvent event,
  ) async* {
    if(event is FetchOrderDetailEvent) {
      ApiResult result = await apiRepository.fetchOrderDetail(OrderDetailReq(orderNo: event.orderNo));
      if(result is Success<OrderDetailResp>) {
        Fimber.d('result: ${result.data?.orderNo ?? '0'}');
        yield LoadedState(result.data!);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
  }
}
