import 'dart:io';

import 'package:flowder/flowder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/bloc/splash/splash_bloc.dart';
import 'package:qfvpn/bloc/splash/splash_event.dart';
import 'package:qfvpn/bloc/splash/splash_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:qfvpn/page/main/main_page.dart';

import '../../r.dart';
import '../../s.dart';
import '../login/login_page.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late DownloaderUtils options;
  late DownloaderCore core;
  late final String path;
  late SplashBloc _splashBloc;
  late ProgressDialog pr;

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

  Future<void> installApp(String path) async {
    try {
      await platform.invokeMethod('installApp', {"path": path});
    } on PlatformException catch (e) {
      debugPrint('installApp error: ${e.message}');
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
    pr = ProgressDialog(context: context);
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNoUpdateState) {
          // Navigator.of(context).pushReplacementNamed((LoginPage).toString());
        } else if(state is SplashForceUpdateState) {
          alert(true, state.downloadUrl, state.releaseNote);
        } else if(state is SplashUpdateState) {
          alert(false, state.downloadUrl, state.releaseNote);
        if (state is NonLoginState) {
          Navigator.of(context).pushReplacementNamed((LoginPage).toString());
        } else if (state is LoginState) {
          Navigator.of(context).pushReplacementNamed((MainPage).toString());
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

  void alert(bool isForce, String downloadUrl, String note) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(S.of(context).alert_update_notification_title),
        content: Text(note),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
            ),
            onPressed: () {
              Navigator.pop(context);
              if(isForce) {
                exit(0);
              } else {
                Navigator.of(context).pushReplacementNamed((LoginPage).toString());
              }
            },
            child: Text(
                isForce
              ? S.of(context).alert_exit_btn
              : S.of(context).alert_skip_btn,
              style: TextStyle(
                color: Color(0xFF6200EE)
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: () async {
              Navigator.pop(context);
              pr.show(
                max: 100,
                msg: S.of(context).alert_file_download,
                progressBgColor: Colors.transparent,
              );
              final path = (await _localPath) +'/app.apk';
              options = DownloaderUtils(
                progressCallback: (current, total) {
                  final progress = (current / total) * 100;
                  pr.update(value: progress.toInt());
                },
                file: File(path),
                progress: ProgressImplementation(),
                onDone: () {
                  if(pr.isOpen()) {
                    pr.close();
                  }
                  installApp(path);
                },
                deleteOnCancel: true,
              );
              core = await Flowder.download(
                  downloadUrl,
                  options);
            },
            child: Text(
              isForce
                  ? S.of(context).alert_force_update_btn
                  : S.of(context).alert_update_btn,
              style: TextStyle(
                  color: Color(0xFF6200EE)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
