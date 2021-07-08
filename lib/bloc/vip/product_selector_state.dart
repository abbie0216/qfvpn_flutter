part of 'product_selector_bloc.dart';

abstract class ProductSelectorState extends Equatable {
  const ProductSelectorState();

  @override
  List<Object> get props => [];
}

class InitState extends ProductSelectorState {}

class LoadedState extends ProductSelectorState {
  final ProductListResult result;
  LoadedState(this.result) : super();

  @override
  List<Object> get props => [result];
}