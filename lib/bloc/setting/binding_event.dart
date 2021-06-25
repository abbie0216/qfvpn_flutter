part of 'binding_bloc.dart';

@immutable
abstract class BindingEvent {}

class SubmitEvent extends BindingEvent {
  final String email;
  final String password;
  final String? invitationCode;
  SubmitEvent({required this.email, required this.password, this.invitationCode}) : super();

}
