part of 'share_detail_bloc.dart';

abstract class ShareDetailState extends Equatable {
  const ShareDetailState();
  @override
  List<Object> get props => [];
}

class InitState extends ShareDetailState {}

class LoadedState extends ShareDetailState {
  final InviteListResp result;
  LoadedState(this.result):super();

  @override
  List<Object> get props => [result];
}