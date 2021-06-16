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
          backgroundColor: Color(R.color.login_bg_color),
          body: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image(
                  image: R.image.img_login_bg(),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Center(
                child: Text(S.of(context).hello_world,
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      }),
    );
  }
}
