part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitState extends LoginState {
}

class LoginEmailInvalidState extends LoginState {
}

class LoginPWInvalidState extends LoginState {
}

class LoginFailedState extends LoginState {
  final int timeStamp;
  final Error errMsg;
  const LoginFailedState(this.timeStamp, this.errMsg): super();

  @override
  List<Object> get props => [timeStamp];
}

class LoginSuccessState extends LoginState {
}
