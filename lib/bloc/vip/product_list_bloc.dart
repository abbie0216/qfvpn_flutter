import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/product/product_list_result.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ApiRepository apiRepository;

  ProductListBloc({required this.apiRepository}) : super(InitState());

  @override
  Stream<ProductListState> mapEventToState(
    ProductListEvent event,
  ) async* {
    if (event is ProductListFetchEvent) {
      ApiResult result = await apiRepository.fetchProductList();
      if (result is Success) {
        yield LoadedState(result.data);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
  }
}
