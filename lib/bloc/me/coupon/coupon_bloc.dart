import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qfvpn/model/api/api_repository.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final ApiRepository apiRepository;

  CouponBloc({required this.apiRepository}) : super(CouponInitial());


  @override
  Stream<CouponState> mapEventToState(
    CouponEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
