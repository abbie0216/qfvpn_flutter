import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/login/register_bloc.dart';
import 'package:qfvpn/widget/MailField.dart';
import 'package:qfvpn/widget/PasswordField.dart';

import '../../r.dart';
import '../../s.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterBloc _registerBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _invitationCodeController =
      TextEditingController();

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          debugPrint('Register success');
        } else if (state is RegisterFailedState) {
          debugPrint('Register failed');
          // ScaffoldMessenger.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(SnackBar(
          //       content: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: <Widget>[
          //           Text(Str.of(context).login_failed),
          //         ],
          //       )));
        }
      },
      child:
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
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
                  _buildLoginMsg()
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
            child: Text(S.of(context).register_title,
                style: TextStyle(color: Colors.white, fontSize: 24))),
      ],
    );
  }

  Widget _buildInputRegion() {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (BuildContext context, RegisterState state) {},
      child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (BuildContext context, RegisterState state) {
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
                      hintColor: R.color.hint_color_deep_bg(),
                      textColor: Colors.white,
                      validator: (value) {
                        return state is RegisterEmailInvalidState
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
                    hintColor: R.color.hint_color_deep_bg(),
                    textColor: Colors.white,
                    validator: (_) {
                      return state is RegisterPWInvalidState
                          ? S.of(context).login_pw_error
                          : null;
                    },
                  ),
                  SizedBox(height: 30),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).register_invitation_code_label,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.left,
                      )),
                  _buildInvitationCodeField(),
                  SizedBox(height: 40),
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
                          _registerBloc.add(SubmitEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                              invitationCode: _invitationCodeController.text));
                        },
                        child: Text(S.of(context).register_and_login,
                            style: TextStyle(
                                color: R.color.text_blue_color(),
                                fontSize: 16)),
                      )),
                  _buildPrivacyPolicyMsg()
                ],
              ),
            ));
      }),
    );
  }

  Widget _buildInvitationCodeField() {
    return TextFormField(
      controller: _invitationCodeController,
      maxLength: 20,
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        counterText: '',
        prefixIcon: Padding(
            padding: EdgeInsets.only(right: 12),
            child: Image(image: R.image.ico_handshake())),
        prefixIconConstraints: BoxConstraints(minWidth: 24, maxHeight: 24),
        hintStyle: TextStyle(color: R.color.hint_color_deep_bg(), fontSize: 14),
        hintText: S.of(context).register_invitation_code_hint,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: R.color.text_field_border_color()),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: R.color.text_field_border_color()),
        ),
      ),
      autovalidateMode: AutovalidateMode.always,
      autocorrect: false,
      style: TextStyle(color: Colors.white),
      validator: (_) {},
    );
  }

  Widget _buildPrivacyPolicyMsg() {
    return Align(
        alignment: FractionalOffset.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).register_policy_msg,
                style:
                    TextStyle(color: R.color.hint_color_deep_bg(), fontSize: 14)),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft),
                onPressed: () {},
                child: Text(S.of(context).policy,
                    style: TextStyle(color: Colors.white, fontSize: 14)))
          ],
        ));
  }

  Widget _buildLoginMsg() {
    return Align(
        alignment: FractionalOffset.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).register_hint,
                style:
                    TextStyle(color: R.color.hint_color_deep_bg(), fontSize: 14)),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed((LoginPage).toString());
                },
                child: Text(S.of(context).login,
                    style: TextStyle(color: Colors.white, fontSize: 14)))
          ],
        ));
  }
}
