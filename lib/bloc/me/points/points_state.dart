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