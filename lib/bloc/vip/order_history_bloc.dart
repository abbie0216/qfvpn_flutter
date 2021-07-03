import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/api_repository.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final ApiRepository apiRepository;

  OrderHistoryBloc({required this.apiRepository}) : super(OrderHistoryInitial());

  @override
  Stream<OrderHistoryState> mapEventToState(
      OrderHistoryEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
