import 'package:equatable/equatable.dart';

abstract class FeedbackEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchFeedbackEvent extends FeedbackEvent {
  final int pageNo;

  FetchFeedbackEvent(this.pageNo);

  @override
  List<Object> get props => [pageNo];
}
