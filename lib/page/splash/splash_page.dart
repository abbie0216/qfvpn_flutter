import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/splash/splash_bloc.dart';
import 'package:qfvpn/bloc/splash/splash_event.dart';
import 'package:qfvpn/bloc/splash/splash_state.dart';

import '../../r.dart';
import '../login/login_page.dart';

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
      final int result =
          await platform.invokeMethod('getFreeSpace', {"packagename": "test"});
      debugPrint('getFreeSpace: $result');
    } on PlatformException catch (e) {
      debugPrint('getFreeSpace error: ${e.message}');
    }
  }

  Future<void> defaultProfile() async {
    try {
      final int result =
          await platform.invokeMethod('defaultProfile', {"packagename": "test"});
      debugPrint('defaultProfile: $result');
    } on PlatformException catch (e) {
      debugPrint('defaultProfile error: ${e.message}');
    }
  }

  Future<void> startVPN() async {
    await Future.delayed(Duration(seconds: 5));
    debugPrint('start VPN...');
    try {
      String result = await platform.invokeMethod('startVPN', {"packagename": "test"});
      debugPrint('startVPN status: $result');
    } on PlatformException catch (e) {
      debugPrint('startVPN error: ${e.message}');
    }
  }

  @override
  void initState() {
    super.initState();
    _splashBloc = BlocProvider.of<SplashBloc>(context);
    _splashBloc.add(SplashCheckVersionEvent());

    getFreeSpace();
    defaultProfile();

    // startVPN();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNoUpdateState) {
          Navigator.of(context).pushReplacementNamed((LoginPage).toString());
        } 
      },
      child: BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: R.color.login_bg_color(),
          body: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image(
                  image: R.image.img_login_bg(),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Align(
                alignment: FractionalOffset(0.5, 0.3),
                child: Container(
                  width: 105,
                  height: 105,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFCFD1FF)),
                  child: Center(
                      child: FlutterLogo(
                    size: 60,
                  )),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
