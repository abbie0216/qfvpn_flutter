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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    // _loginBloc.add(LoginFetchEvent());

    _emailController.addListener(_onEmailChanged);
    // _passwordController.addListener(_onPasswordChanged);
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  // void _onPasswordChanged() {
  //   _loginBloc.add(PasswordChanged(password: _passwordController.text));
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // if (state is LoginFetchEvent) {
        // Navigator.pushReplacement(
        // context,
        // MaterialPageRoute(
        //   builder: (BuildContext pageContext) => HomePage()));
        // }
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
                  TextFormField(
                    controller: _emailController,
                    maxLength: 20,
                    maxLines: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Image(image: R.image.ico_mail())),
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 24, maxHeight: 24),
                      hintStyle: TextStyle(
                          color: R.color.login_hint_color(), fontSize: 14),
                      hintText: S.of(context).login_email_hint,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: R.color.text_field_border_color()),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: R.color.text_field_border_color()),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      return !state.isEmailValid
                          ? S.of(context).login_email_error
                          : null;
                    },
                  ),

                  SizedBox(height: 30),

                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).login_pw_label,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.left,
                      )),

                  TextFormField(
                    controller: _passwordController,
                    maxLength: 20,
                    maxLines: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Image(image: R.image.ico_lock())),
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 24, maxHeight: 24),
                      suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: IconButton(
                            icon: Image(
                                image: state.showPassword
                                    ? R.image.ico_eye()
                                    : R.image.ico_eyeslash()),
                            onPressed: () {
                              _loginBloc.add(ShowPasswordChanged());
                            },
                          )),
                      hintStyle: TextStyle(
                          color: R.color.login_hint_color(), fontSize: 14),
                      hintText: S.of(context).login_pw_hint,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: R.color.text_field_border_color()),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: R.color.text_field_border_color()),
                      ),
                    ),
                    obscureText: !state.showPassword,
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    style: TextStyle(color: Colors.white),
                    validator: (_) {
                      // return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.centerRight),
                          onPressed: () {
                            // Navigator.pushNamed(context, "YourRoute");
                          },
                          child: Text(S.of(context).login_forget_pw_btn,
                              style: TextStyle(
                                  color: R.color.login_hint_color(),
                                  fontSize: 14))))

                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 20.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.stretch,
                  //     children: <Widget>[
                  //       LoginButton(
                  //           onPressed: isLoginButtonEnabled(state)
                  //               ? _onFormSubmitted
                  //               : null),
                  //
                  //       GoogleSignInButton(
                  //         onPressed: () =>
                  //             _loginBloc.dispatch(LoginWithGooglePressed()),
                  //       ),
                  //       CreateAccountButton(userRepository: _userRepository)
                  //     ],
                  //   ),
                  // )
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
                  // Navigator.pushNamed(context, "YourRoute");
                },
                child: Text(S.of(context).login_register_btn,
                    style: TextStyle(color: Colors.white, fontSize: 14)))
          ],
        ));
  }
}
