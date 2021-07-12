import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/bean/feedback/detail_resp.dart';

abstract class FeedbackDetailState extends Equatable {
  const FeedbackDetailState();

  @override
  List<Object> get props => [];
}

class InitState extends FeedbackDetailState {}

class LoadedState extends FeedbackDetailState {
  final DetailResp result;
  LoadedState(this.result):super();

  @override
  List<Object> get props => [result];
}

class ErrorState extends FeedbackDetailState {
  final String error;
  ErrorState(this.error):super();

  @override
  List<Object> get props => [error];
}