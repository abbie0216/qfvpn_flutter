import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/product/product_list_resp.dart';

part 'product_selector_event.dart';

part 'product_selector_state.dart';

class ProductSelectorBloc extends Bloc<ProductSelectorEvent, ProductSelectorState> {
  final ApiRepository apiRepository;

  ProductSelectorBloc({required this.apiRepository}) : super(InitState());

  @override
  Stream<ProductSelectorState> mapEventToState(
    ProductSelectorEvent event,
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
