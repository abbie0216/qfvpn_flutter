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

class VpnConnectProfileEditEvent extends VpnEvent {
  final String type;
  final String server;
  final String port;
  final String cipher;
  final String password;
  final String udp;

  const VpnConnectProfileEditEvent(
      this.type,
      this.server,
      this.port,
      this.cipher,
      this.password,
      this.udp
  ): super();

  @override
  List<Object> get props => [type, server, port, cipher, password, udp];
}