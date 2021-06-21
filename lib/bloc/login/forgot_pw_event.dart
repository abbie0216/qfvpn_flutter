part of 'forgot_pw_bloc.dart';

abstract class ForgotPwEvent {
  const ForgotPwEvent();
}

class SendCodeStart extends ForgotPwEvent {
  SendCodeStart() : super();
}

class SendCodeTimer extends ForgotPwEvent {
  final int time;
  SendCodeTimer(this.time): super();
}

class SendCodeAgain extends ForgotPwEvent {
  SendCodeAgain() : super();
}


class SubmitEvent extends ForgotPwEvent {
  final String email;
  final String password;
  final String verificationCode;
  SubmitEvent({required this.email, required this.password, required this.verificationCode}) : super();
}
