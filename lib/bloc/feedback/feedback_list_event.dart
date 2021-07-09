import 'package:equatable/equatable.dart';

abstract class FeedbackListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchListEvent extends FeedbackListEvent {
  final int pageNo;

  FetchListEvent(this.pageNo);

  @override
  List<Object> get props => [pageNo];
}
