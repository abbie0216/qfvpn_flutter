part of 'option_line_bloc.dart';

abstract class OptionLineEvent extends Equatable {
  const OptionLineEvent();

  @override
  List<Object> get props => [];
}

class OptionLineFetchEvent extends OptionLineEvent{}
