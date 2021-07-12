part of 'points_bloc.dart';

@immutable
abstract class PointsEvent extends Equatable {
  // final List equalProps;
  // const LoginEvent([this.equalProps = const []]);
  const PointsEvent();

  @override
  List<Object> get props => [];
}

class FetchInfoEvent extends PointsEvent {
  FetchInfoEvent();
}

class CheckInEvent extends PointsEvent {
  CheckInEvent();
}
