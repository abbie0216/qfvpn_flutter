part of 'pw_change_bloc.dart';

@immutable
abstract class PwChangeEvent {}

class SubmitEvent extends PwChangeEvent {
  final String orgPassword;
  final String newPassword;
  SubmitEvent({required this.orgPassword, required this.newPassword}) : super();

}
