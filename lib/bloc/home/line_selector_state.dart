part of 'line_selector_bloc.dart';

abstract class LineSelectorState extends Equatable {
  const LineSelectorState();

  @override
  List<Object> get props => [];
}

class InitState extends LineSelectorState {}

class LoadedState extends LineSelectorState {
  final NodeListResp result;

  const LoadedState(this.result) : super();

  @override
  List<Object> get props => [result];
}
