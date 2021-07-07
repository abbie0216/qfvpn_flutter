part of 'option_line_bloc.dart';

abstract class OptionLineState extends Equatable {
  const OptionLineState();

  @override
  List<Object> get props => [];
}

class InitState extends OptionLineState {}

class LoadedState extends OptionLineState {
  final NodeListResult result;

  const LoadedState(this.result) : super();

  @override
  List<Object> get props => [result];
}
