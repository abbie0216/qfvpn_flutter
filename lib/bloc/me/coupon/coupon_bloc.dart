import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/user/UserCouponListResp.dart';
import 'package:qfvpn/model/api/bean/paging.dart';

import '../../../constants.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final ApiRepository apiRepository;

  CouponBloc({required this.apiRepository}) : super(CouponInitial());


  @override
  Stream<CouponState> mapEventToState(
    CouponEvent event,
  ) async* {
    if (event is FetchListEvent) {
      ApiResult result = await apiRepository
          .fetchUserCouponList(Paging(pageNo: event.pageNo, pageSize: PAGE_SIZE));
      if (result is Success) {
        yield ListLoadedState(result.data);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
  }




}
