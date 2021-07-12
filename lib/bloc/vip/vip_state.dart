part of 'vip_bloc.dart';

abstract class VipState extends Equatable {
  const VipState();
  @override
  List<Object> get props => [];
}

class InitState extends VipState {}

class UserInfoUpdatedState extends VipState {
  final User userInfo;
  const UserInfoUpdatedState(this.userInfo);
}

class ErrorState extends VipState {
  final dynamic error;
  final int _timeStamp = DateTime.now().millisecondsSinceEpoch;
  ErrorState(this.error);

  @override
  List<Object> get props => [_timeStamp];
}

