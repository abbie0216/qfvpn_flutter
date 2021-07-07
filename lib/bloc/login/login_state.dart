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
  final dynamic errMsg;
  const LoginFailedState(this.timeStamp, this.errMsg);

  @override
  List<Object> get props => [timeStamp];
}

class LoginSuccessState extends LoginState {
  final int timeStamp;
  const LoginSuccessState(this.timeStamp);
  @override
  List<Object> get props => [timeStamp];
}
