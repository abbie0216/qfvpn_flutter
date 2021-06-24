part of 'pw_change_bloc.dart';

@immutable
abstract class PwChangeState extends Equatable {
  const PwChangeState();

  @override
  List<Object> get props => [];
}

class PwChangeInitState extends PwChangeState {}

class OrgPWInvalidState extends PwChangeState {
}
class NewPWInvalidState extends PwChangeState {
}

class PwChangeFailedState extends PwChangeState {
  final int timeStamp;
  const PwChangeFailedState(this.timeStamp): super();

  @override
  List<Object> get props => [timeStamp];
}

class PwChangeSuccessState extends PwChangeState {
}

