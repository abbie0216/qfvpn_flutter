part of 'points_detail_bloc.dart';

abstract class PointsDetailEvent extends Equatable {
  const PointsDetailEvent();
  @override
  List<Object> get props => [];
}

class FetchListEvent extends PointsDetailEvent {
  final int pageNo;

  FetchListEvent(this.pageNo);
}
