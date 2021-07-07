part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class InitState extends ProductListState {}

class LoadedState extends ProductListState {
  final ProductListResult result;
  LoadedState(this.result) : super();

  @override
  List<Object> get props => [result];
}
