part of 'me_bloc.dart';

abstract class MeState extends Equatable {
  const MeState();
  @override
  List<Object> get props => [];
}

class MeInitState extends MeState {}

class AppVersionState extends MeState {
  final String appVersion;
  const AppVersionState({required this.appVersion});
}

class UserInfoUpdatedState extends MeState {
  final User userInfo;
  const UserInfoUpdatedState(this.userInfo);
}

class ErrorState extends MeState {
  final dynamic error;
  final int _timeStamp = DateTime.now().millisecondsSinceEpoch;
  ErrorState(this.error);

  @override
  List<Object> get props => [_timeStamp];
}