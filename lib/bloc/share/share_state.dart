part of 'share_bloc.dart';

abstract class ShareState extends Equatable {
  const ShareState();

  @override
  List<Object> get props => [];
}

class InitState extends ShareState {}

class LoadedState extends ShareState {
  final InviteInfoResp result;
  LoadedState(this.result) : super();

  @override
  List<Object> get props => [result];
}