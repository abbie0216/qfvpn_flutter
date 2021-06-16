import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/login/login_bloc.dart';
import 'package:qfvpn/bloc/splash/splash_event.dart';

import '../../r.dart';
import '../../s.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _loginBloc.add(LoginFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFetchEvent) {
          // Navigator.pushReplacement(
          // context,
          // MaterialPageRoute(
          //   builder: (BuildContext pageContext) => HomePage()));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: R.color.login_bg_color(),
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned.fill(
                child: Image(
                  image: R.image.img_login_bg(),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(28.0, 40.0, 28.0, 30.0),
                child: Stack(fit: StackFit.expand, children: <Widget>[
                  _buildTitle(),
                  // _buildBody(),
                  _buildRegisterMsg()
                ]),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 45,
          height: 45,
          margin: EdgeInsets.only(left: 7.5),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: R.color.logo_bg_color()),
          child: Center(
              child: FlutterLogo(
            size: 30,
          )),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(S.of(context).login_title,
                style: TextStyle(color: Colors.white, fontSize: 24))),
      ],
    );
  }

  Widget _buildRegisterMsg() {
    return  Align(
          alignment: FractionalOffset.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).login_register_hint,
                  style: TextStyle(
                      color: R.color.login_hint_color(), fontSize: 14)),
              TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft),
                  onPressed: () {
                    // Navigator.pushNamed(context, "YourRoute");
                  },
                  child: Text(S.of(context).login_register_btn,
                      style: TextStyle(color: Colors.white, fontSize: 14)))
            ],
          )
    );
  }
}
