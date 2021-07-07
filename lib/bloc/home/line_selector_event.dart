part of 'line_selector_bloc.dart';

abstract class LineSelectorEvent extends Equatable {
  const LineSelectorEvent();

  @override
  List<Object> get props => [];
}

class LineSelectorFetchEvent extends LineSelectorEvent{}
