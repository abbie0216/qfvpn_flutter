import 'package:equatable/equatable.dart';

abstract class AddFeedbackState extends Equatable {
  const AddFeedbackState();

  @override
  List<Object> get props => [];
}

class InitState extends AddFeedbackState {}