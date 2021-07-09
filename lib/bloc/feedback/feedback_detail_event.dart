import 'package:equatable/equatable.dart';

abstract class FeedbackDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDetailEvent extends FeedbackDetailEvent {
  final int feedbackId;

  FetchDetailEvent(this.feedbackId);

  @override
  List<Object> get props => [feedbackId];
}
