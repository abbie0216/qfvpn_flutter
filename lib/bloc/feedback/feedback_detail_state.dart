import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/bean/feedback/detail_resp.dart';

abstract class FeedbackDetailState extends Equatable {
  const FeedbackDetailState();

  @override
  List<Object> get props => [];
}

class InitState extends FeedbackDetailState {}
class LoadingState extends FeedbackDetailState {}
class LoadedState extends FeedbackDetailState {}

class DetailLoadedState extends FeedbackDetailState {
  final DetailResp result;

  DetailLoadedState(this.result) : super();

  @override
  List<Object> get props => [result];
}

class DetailErrorState extends FeedbackDetailState {
  final String error;

  DetailErrorState(this.error) : super();

  @override
  List<Object> get props => [error];
}

class CreateReplySuccessState extends FeedbackDetailState {}

class CreateReplyErrorState extends FeedbackDetailState {
  final String error;

  CreateReplyErrorState(this.error) : super();

  @override
  List<Object> get props => [error];
}

class TakeSurveySuccessState extends FeedbackDetailState {}

class TakeSurveyErrorState extends FeedbackDetailState {
  final String error;

  TakeSurveyErrorState(this.error) : super();

  @override
  List<Object> get props => [error];
}
