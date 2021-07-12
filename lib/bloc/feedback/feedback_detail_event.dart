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

class CreateReplyEvent extends FeedbackDetailEvent {
  final int feedbackId;
  final String content;
  final List<String> filePathList;

  CreateReplyEvent(this.feedbackId, this.content, this.filePathList);

  @override
  List<Object> get props => [feedbackId, content, filePathList];
}

class TakeSurveyEvent extends FeedbackDetailEvent {
  final int feedbackId;
  final int voteNumber;

  TakeSurveyEvent(this.feedbackId, this.voteNumber);

  @override
  List<Object> get props => [feedbackId, voteNumber];
}