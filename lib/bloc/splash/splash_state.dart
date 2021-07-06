import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitState extends SplashState {}

class SplashLoadedState extends SplashState {}

class SplashUpdateState extends SplashState{
  final String downloadUrl;
  final String releaseNote;
  final int timeStamp;
  const SplashUpdateState(this.downloadUrl, this.releaseNote, this.timeStamp): super();

  @override
  List<Object> get props => [downloadUrl, releaseNote];
}

class SplashForceUpdateState extends SplashState{
  final String downloadUrl;
  final String releaseNote;
  final int timeStamp;
  const SplashForceUpdateState(this.downloadUrl, this.releaseNote, this.timeStamp): super();

  @override
  List<Object> get props => [downloadUrl, releaseNote, timeStamp];
}

class SplashNoUpdateState extends SplashState{}
class LoginState extends SplashState {}
class NonLoginState extends SplashState {}
