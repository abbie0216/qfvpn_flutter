part of 'product_selector_bloc.dart';

abstract class ProductSelectorEvent extends Equatable {
  const ProductSelectorEvent();

  @override
  List<Object> get props => [];
}

class ProductListFetchEvent extends ProductSelectorEvent {}
