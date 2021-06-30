import 'package:equatable/equatable.dart';

abstract class VpnState extends Equatable {
  const VpnState();

  @override
  List<Object> get props => [];
}

class VpnInitState extends VpnState {}

class VpnStartState extends VpnState {
  final int timeStamp;
  const VpnStartState(this.timeStamp): super();

  @override
  List<Object> get props => [timeStamp];
}

class VpnStopState extends VpnState {
  final int timeStamp;
  const VpnStopState(this.timeStamp): super();

  @override
  List<Object> get props => [timeStamp];
}

class VpnLoadedState extends VpnState {}