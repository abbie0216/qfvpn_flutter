part of 'option_btn_bloc.dart';

abstract class OptionBtnEvent extends Equatable {
  const OptionBtnEvent();

  @override
  List<Object> get props => [];
}

class OptionBtnFetchEvent extends OptionBtnEvent {}