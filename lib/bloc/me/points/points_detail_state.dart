part of 'points_detail_bloc.dart';

abstract class PointsDetailState extends Equatable {
  const PointsDetailState();
}

class PointsDetailInitial extends PointsDetailState {
  @override
  List<Object> get props => [];
}

class ListLoadedState extends PointsDetailState {
  final PointsDetailResp data;

  ListLoadedState(this.data);

  @override
  List<Object> get props => [data];
}