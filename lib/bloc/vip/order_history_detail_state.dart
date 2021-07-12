part of 'order_history_detail_bloc.dart';

@immutable
abstract class OrderHistoryDetailState extends Equatable {
  const OrderHistoryDetailState();

  @override
  List<Object> get props => [];
}

class OrderHistoryDetailInitial extends OrderHistoryDetailState {}

class LoadedState extends OrderHistoryDetailState {
  final OrderDetailResp result;
  LoadedState(this.result):super();

  @override
  List<Object> get props => [result];
}
