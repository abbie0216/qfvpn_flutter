part of 'share_detail_bloc.dart';

abstract class ShareDetailEvent extends Equatable {
  const ShareDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchListEvent extends ShareDetailEvent {
  final int pageNo;

  FetchListEvent(this.pageNo);

  @override
  List<Object> get props => [pageNo];
}