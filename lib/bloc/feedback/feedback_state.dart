import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/bean/feedback/feedback_list_resp.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

class FeedbackInitState extends FeedbackState {}

class LoadedState extends FeedbackState {
  final FeedbackListResp result;
  LoadedState(this.result):super();

  @override
  List<Object> get props => [result];
}