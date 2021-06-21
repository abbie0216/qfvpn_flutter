part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterEmailInvalidState extends RegisterState {
}

class RegisterPWInvalidState extends RegisterState {
}

class RegisterFailedState extends RegisterState {
  final int timeStamp;
  const RegisterFailedState(this.timeStamp): super();

  @override
  List<Object> get props => [timeStamp];
}

class RegisterSuccessState extends RegisterState {
}
