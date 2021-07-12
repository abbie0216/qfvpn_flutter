part of 'order_history_detail_bloc.dart';

abstract class OrderHistoryDetailEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchOrderDetailEvent extends OrderHistoryDetailEvent {
  final String orderNo;

  FetchOrderDetailEvent(this.orderNo);

  @override
  List<Object> get props => [orderNo];
}
