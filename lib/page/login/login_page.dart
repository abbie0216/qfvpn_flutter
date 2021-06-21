import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/login/login_bloc.dart';
import 'package:qfvpn/page/login/forgot_pw_page.dart';
import 'package:qfvpn/page/login/register_page.dart';
import 'package:qfvpn/widgets/MailField.dart';
import 'package:qfvpn/widgets/PasswordField.dart';

import '../../r.dart';
import '../../s.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    // _loginBloc.add(LoginFetchEvent());

    // _emailController.addListener(_onEmailChanged);
  }

  // void _onEmailChanged() {
  //   _loginBloc.add(SubmitEvent(email: _emailController.text));
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          debugPrint('login success');
        } else if (state is LoginFailedState) {
          debugPrint('login failed');
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(S.of(context).login_failed),
              ],
            )));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: R.color.login_bg_color(),
          resizeToAvoidBottomInset: false,
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
                  _buildInputRegion(),
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

  Widget _buildInputRegion() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {},
      child: BlocBuilder<LoginBloc, LoginState>(
          builder: (BuildContext context, LoginState state) {
        return Positioned.fill(
            top: 150,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).login_email_label,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.left,
                      )),
                  MailField(
                      prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Image(image: R.image.ico_mail())),
                      controller: _emailController,
                      hintColor: R.color.login_hint_color(),
                      textColor: Colors.white,
                      validator: (value) {
                        return state is LoginEmailInvalidState
                            ? S.of(context).login_email_error
                            : null;
                      }),
                  SizedBox(height: 30),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).login_pw_label,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.left,
                      )),
                  PasswordField(
                    prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Image(image: R.image.ico_lock())),
                    suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: IconButton(
                          icon: Image(
                              image: showPassword
                                  ? R.image.ico_eye()
                                  : R.image.ico_eyeslash()),
                          onPressed: () {
                            showPassword = !showPassword;
                            setState(() {});
                          },
                        )),
                    obscureText: !showPassword,
                    controller: _passwordController,
                    hintColor: R.color.login_hint_color(),
                    textColor: Colors.white,
                    validator: (_) {
                      return state is LoginPWInvalidState
                          ? S.of(context).login_pw_error
                          : null;
                    },
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.centerRight),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed((ForgotPwPage).toString());
                          },
                          child: Text(S.of(context).login_forget_pw,
                              style: TextStyle(
                                  color: R.color.login_hint_color(),
                                  fontSize: 14)))),
                  SizedBox(height: 30),
                  Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(double.infinity, 44),
                          backgroundColor: R.color.btn_white_color(),
                          elevation: 5.0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                          ),
                        ),
                        onPressed: () {
                          _loginBloc.add(SubmitEvent(
                              email: _emailController.text,
                              password: _passwordController.text));
                        },
                        child: Text(S.of(context).login,
                            style: TextStyle(
                                color: R.color.text_blue_color(),
                                fontSize: 16)),
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, "YourRoute");
                          },
                          child: Text(S.of(context).login_by_visitor,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14)))),
                ],
              ),
            ));
      }),
    );
  }

  Widget _buildRegisterMsg() {
    return Align(
        alignment: FractionalOffset.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).login_register_hint,
                style:
                    TextStyle(color: R.color.login_hint_color(), fontSize: 14)),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed((RegisterPage).toString());
                },
                child: Text(S.of(context).login_register_btn,
                    style: TextStyle(color: Colors.white, fontSize: 14)))
          ],
        ));
  }
}
