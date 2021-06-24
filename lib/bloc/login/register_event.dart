part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class SubmitEvent extends RegisterEvent {
  final String email;
  final String password;
  final String? invitationCode;
  SubmitEvent({required this.email, required this.password, this.invitationCode}) : super();

}
