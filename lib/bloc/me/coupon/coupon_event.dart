part of 'coupon_bloc.dart';

@immutable
abstract class CouponEvent extends Equatable {
  const CouponEvent();

  @override
  List<Object> get props => [];
}

class FetchListEvent extends CouponEvent {
  final int pageNo;

  FetchListEvent(this.pageNo);
}


