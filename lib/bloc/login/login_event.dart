part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// class LoginFetchEvent extends LoginEvent {}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({required this.email}) : super();

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class ShowPasswordChanged extends LoginEvent {
}
