part of 'coupon_bloc.dart';

@immutable
abstract class CouponState extends Equatable {
  const CouponState();

  @override
  List<Object> get props => [];
}

class CouponInitial extends CouponState {}

class ListLoadedState extends CouponState {
  final UserCouponListResp data;

  ListLoadedState(this.data);

  @override
  List<Object> get props => [data];
}