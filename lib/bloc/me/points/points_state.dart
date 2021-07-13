part of 'points_bloc.dart';

@immutable
abstract class PointsState extends Equatable {
  const PointsState();

  @override
  List<Object> get props => [];
}

class PointsInitial extends PointsState {}

class PointsInfoState extends PointsState {
  final PointsInfoResp data;
  PointsInfoState({required this.data});

  @override
  List<Object> get props => [data];
}

class PrizeListState extends PointsState {
  final PrizeListResp data;
  PrizeListState({required this.data});

  @override
  List<Object> get props => [data];
}

class PrizeExchangeSuccess extends PointsState{
  final int _timeStamp = DateTime.now().millisecondsSinceEpoch;
  PrizeExchangeSuccess(): super();

  @override
  List<Object> get props => [_timeStamp];
}

class PrizeExchangeFail extends PointsState {
  final int _timeStamp = DateTime.now().millisecondsSinceEpoch;
  final dynamic error;
  PrizeExchangeFail(this.error): super();

  @override
  List<Object> get props => [_timeStamp];
}