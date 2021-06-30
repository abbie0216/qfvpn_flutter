import 'package:equatable/equatable.dart';

abstract class VpnEvent extends Equatable {
  const VpnEvent();

  @override
  List<Object> get props => [];
}

class VpnFetchEvent extends VpnEvent{}

class VpnServiceStartEvent extends VpnEvent {}

class VpnServiceStopEvent extends VpnEvent {}

class VpnPermissionSuccessEvent extends VpnEvent {}

class VpnPermissionFailedEvent extends VpnEvent {}