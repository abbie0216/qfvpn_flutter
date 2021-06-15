
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/splash/splash_bloc.dart';
import 'package:qfvpn/bloc/splash/splash_event.dart';
import 'package:qfvpn/bloc/splash/splash_state.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashBloc _splashBloc;

  static const platform = const MethodChannel('com.example.flutter_demo/app');

  Future<void> getFreeSpace() async {
    try {
      final int result = await platform.invokeMethod('getFreeSpace', {"packagename":"test"});
      debugPrint('getFreeSpace: $result');
    } on PlatformException catch (e) {
      debugPrint('getFreeSpace error: ${e.message}');
    }
  }

  @override
  void initState() {
    super.initState();
    _splashBloc = BlocProvider.of<SplashBloc>(context);
    _splashBloc.add(SplashFetchEvent());
    getFreeSpace();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoadedState) {

        }
      },
      child: BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
        return Center(
          child: Text('SplashPage', style: TextStyle(color: Colors.white)),
        );
      }),);
  }
}
