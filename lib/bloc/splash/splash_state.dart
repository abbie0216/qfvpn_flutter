import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitState extends SplashState {}

class LoginState extends SplashState {}
class NonLoginState extends SplashState {}