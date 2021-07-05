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
  final int timeStamp;
  final dynamic error;
  const RegisterFailedState(this.timeStamp, this.error): super();

  @override
  List<Object> get props => [timeStamp];
}

class RegisterSuccessState extends RegisterState {
}

class LoginFailedState extends RegisterState {
  final int timeStamp;
  final dynamic errMsg;
  const LoginFailedState(this.timeStamp, this.errMsg): super();

  @override
  List<Object> get props => [timeStamp];
}

class LoginSuccessState extends RegisterState {
}

