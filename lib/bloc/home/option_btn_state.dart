part of 'option_btn_bloc.dart';

abstract class OptionBtnState extends Equatable {
  const OptionBtnState();

  @override
  List<Object> get props => [];
}

class InitState extends OptionBtnState {}

class LoadedState extends OptionBtnState {
  final OptionBtnInfo result;
  LoadedState(this.result):super();

  @override
  List<Object> get props => [result];
}