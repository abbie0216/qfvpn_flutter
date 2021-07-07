import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class SplashFetchEvent extends SplashEvent {}

class SplashCheckVersionEvent extends SplashEvent {}