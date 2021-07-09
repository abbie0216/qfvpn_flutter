part of 'order_history_bloc.dart';

abstract class OrderHistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchOrdersListEvent extends OrderHistoryEvent {
  final int pageNo;

  FetchOrdersListEvent(this.pageNo);

  @override
  List<Object> get props => [pageNo];
}