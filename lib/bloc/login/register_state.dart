part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterEmailInvalidState extends RegisterState {
}

class RegisterPWEmptyState extends RegisterState {
}

class RegisterPWInvalidState extends RegisterState {
}

class RegisterFailedState extends RegisterState {
  final int _timeStamp = DateTime.now().millisecondsSinceEpoch;
  final dynamic error;
  RegisterFailedState(this.error): super();

  @override
  List<Object> get props => [_timeStamp];
}

class RegisterSuccessState extends RegisterState {
}

class LoginFailedState extends RegisterState {
  final int _timeStamp = DateTime.now().millisecondsSinceEpoch;
  final dynamic errMsg;
  LoginFailedState(this.errMsg): super();

  @override
  List<Object> get props => [_timeStamp];
}

class LoginSuccessState extends RegisterState {
}

