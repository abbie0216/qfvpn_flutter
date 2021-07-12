part of 'vip_bloc.dart';

abstract class VipEvent extends Equatable {
  const VipEvent();
  @override
  List<Object?> get props => [];
}

class GetUserInfoEvent extends VipEvent {}