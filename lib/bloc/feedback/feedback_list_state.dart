import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/bean/feedback/feedback_list_resp.dart';

abstract class FeedbackListState extends Equatable {
  const FeedbackListState();

  @override
  List<Object> get props => [];
}

class InitState extends FeedbackListState {}

class LoadedState extends FeedbackListState {
  final FeedbackListResp result;
  LoadedState(this.result):super();

  @override
  List<Object> get props => [result];
}