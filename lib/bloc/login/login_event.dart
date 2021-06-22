part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  // final List equalProps;
  // const LoginEvent([this.equalProps = const []]);
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SubmitEvent extends LoginEvent {
  final String email;
  final String password;
  SubmitEvent({required this.email, required this.password}) : super();

  @override
  String toString() => 'SubmitEvent { email :$email , pw: $password }';
}
