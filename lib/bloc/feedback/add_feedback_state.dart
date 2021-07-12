import 'package:equatable/equatable.dart';

abstract class AddFeedbackState extends Equatable {
  const AddFeedbackState();

  @override
  List<Object> get props => [];
}

class InitState extends AddFeedbackState {}

class LoadedState extends AddFeedbackState {}

class ErrorState extends AddFeedbackState {
  final String error;
  ErrorState(this.error):super();

  @override
  List<Object> get props => [error];
}