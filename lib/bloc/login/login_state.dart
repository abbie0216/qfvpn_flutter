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
  final int _timeStamp = DateTime.now().millisecondsSinceEpoch;
  final dynamic errMsg;
  LoginFailedState(this.errMsg);

  @override
  List<Object> get props => [_timeStamp];
}

class LoginSuccessState extends LoginState {
  final int _timeStamp = DateTime.now().millisecondsSinceEpoch;
  LoginSuccessState();
  @override
  List<Object> get props => [_timeStamp];
}
