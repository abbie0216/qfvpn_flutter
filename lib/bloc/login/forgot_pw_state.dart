part of 'forgot_pw_bloc.dart';

abstract class ForgotPwState extends Equatable {
  const ForgotPwState();

  @override
  List<Object> get props => [];
}

class ForgotPwInitial extends ForgotPwState {
  @override
  List<Object> get props => [];
}

class CodeCountDownState extends ForgotPwState {
  final int time;
  const CodeCountDownState(this.time);

  @override
  List<Object> get props => [time];
}
class CodeSendState extends ForgotPwState {
}

class EmailInvalidState extends ForgotPwState {
}

class PWInvalidState extends ForgotPwState {
}

class VerificationCodeInvalidState extends ForgotPwState {
}

class ForgotPwFailedState extends ForgotPwState {
  final int timeStamp;
  const ForgotPwFailedState(this.timeStamp): super();

  @override
  List<Object> get props => [timeStamp];
}

class ForgotPwSuccessState extends ForgotPwState {
}
