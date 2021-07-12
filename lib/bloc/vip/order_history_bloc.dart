import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/paging.dart';
import 'package:qfvpn/constants.dart';
import 'package:qfvpn/model/api/bean/order/orders_list_resp.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final ApiRepository apiRepository;

  OrderHistoryBloc({required this.apiRepository}) : super(OrderHistoryInitial());

  @override
  Stream<OrderHistoryState> mapEventToState(
      OrderHistoryEvent event,
  ) async* {
    if(event is FetchOrdersListEvent) {
      ApiResult result = await apiRepository
          .fetchOrdersList(Paging(pageNo: event.pageNo, pageSize: PAGE_SIZE));
      if(result is Success<OrdersListResp>) {
        Fimber.d('result: ${result.data?.totalCount ?? 0}');
        yield LoadedState(result.data!);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
  }
}
