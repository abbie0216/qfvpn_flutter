part of 'pay_bloc.dart';

abstract class PayState extends Equatable {
  const PayState();
}

class PayInitial extends PayState {
  @override
  List<Object> get props => [];
}
