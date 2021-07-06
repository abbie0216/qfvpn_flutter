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
  const SplashUpdateState(this.downloadUrl): super();

  @override
  List<Object> get props => [downloadUrl];
}

class SplashForceUpdateState extends SplashState{
  final String downloadUrl;
  const SplashForceUpdateState(this.downloadUrl): super();

  @override
  List<Object> get props => [downloadUrl];
}

class SplashNoUpdateState extends SplashState{}
