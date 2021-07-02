import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';

part 'order_history_detail_event.dart';
part 'order_history_detail_state.dart';

class OrderHistoryDetailBloc extends Bloc<OrderHistoryDetailEvent, OrderHistoryDetailState> {
  final ApiRepository apiRepository;
  OrderHistoryDetailBloc({required this.apiRepository}) : super(OrderHistoryDetailInitial());

  @override
  Stream<OrderHistoryDetailState> mapEventToState(
    OrderHistoryDetailEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
