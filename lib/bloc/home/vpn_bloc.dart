import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:qfvpn/model/api/api_repository.dart';

import 'vpn_event.dart';
import 'vpn_state.dart';

class VpnBloc extends Bloc<VpnEvent, VpnState> {
  final ApiRepository apiRepository;

  VpnBloc({required this.apiRepository}) : super(VpnInitState());

  static const _channel = MethodChannel('com.example.flutter_demo/app');

  @override
  Stream<VpnState> mapEventToState(VpnEvent event) async* {
    if(event is VpnFetchEvent) {
      _channel.setMethodCallHandler( (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'VPN_Permission': {
            if(!methodCall.arguments) {
              add(VpnPermissionFailedEvent());
            } else {
              add(VpnPermissionSuccessEvent());
            }
          }
        }
      });
    } else if(event is VpnServiceStartEvent) {
      try {
        int result = await _channel.invokeMethod('startVPN');
        switch(result) {
          case 0 :
            yield VpnStartState(DateTime.now().millisecondsSinceEpoch);
            break;
          case -1 :
            yield VpnStopState(DateTime.now().millisecondsSinceEpoch);
            break;
        }
      } on PlatformException catch (e) {
        await _channel.invokeMethod('stopVPN');
        yield VpnStopState(DateTime.now().millisecondsSinceEpoch);
      }
    } else if(event is VpnServiceStopEvent || event is VpnPermissionFailedEvent) {
      await _channel.invokeMethod('stopVPN');
      yield VpnStopState(DateTime.now().millisecondsSinceEpoch);
    } else if(event is VpnPermissionSuccessEvent) {
      yield VpnStartState(DateTime.now().millisecondsSinceEpoch);
    } else if(event is VpnConnectProfileEditEvent) {
      await _channel.invokeMethod('connectProfile',
          { 'type':event.type,
            'server':event.server,
            'port' : event.port,
            'cipher' : event.cipher,
            'password' : event.password,
            'udp' : event.udp
          });
      yield VpnLoadedState();
    }
  }
}