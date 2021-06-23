part of 'binding_bloc.dart';

@immutable
abstract class BindingState extends Equatable {
  const BindingState();

  @override
  List<Object> get props => [];
}

class BindingInitState extends BindingState {}

class BindingEmailInvalidState extends BindingState {
}

class BindingPWInvalidState extends BindingState {
}

class BindingFailedState extends BindingState {
  final int timeStamp;
  const BindingFailedState(this.timeStamp): super();

  @override
  List<Object> get props => [timeStamp];
}

class BindingSuccessState extends BindingState {
}

