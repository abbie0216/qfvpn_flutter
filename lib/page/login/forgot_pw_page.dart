import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/login/forgot_pw_bloc.dart';
import 'package:qfvpn/widget/MailField.dart';
import 'package:qfvpn/widget/PasswordField.dart';

import '../../r.dart';
import '../../s.dart';

class ForgotPwPage extends StatefulWidget {
  ForgotPwPage({Key? key}) : super(key: key);

  @override
  _ForgotPwPageState createState() => _ForgotPwPageState();
}

class _ForgotPwPageState extends State<ForgotPwPage> {
  late ForgotPwBloc _forgotPwBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _forgotPwBloc = BlocProvider.of<ForgotPwBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPwBloc, ForgotPwState>(
      listener: (context, state) {
        if (state is CodeCountDownState && state.time == 60) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(S.of(context).verification_code_sent),
                  ],
                )));
        } else if(state is ForgotPwSuccessState) {
          debugPrint('success');
        } else if (state is ForgotPwFailedState) {
          debugPrint('failed');
        }
      },
      child:
          BlocBuilder<ForgotPwBloc, ForgotPwState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: R.color.background_color(),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(S.of(context).login_forget_pw,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon:
                  Icon(Icons.arrow_back_ios, color: R.color.text_blue_color()),
              onPressed: () => Navigator.of(context).pop(),
            ),
            elevation: 0,
            backgroundColor: R.color.background_color(),
            centerTitle: true,
          ),
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(28.0, 40.0, 28.0, 30.0),
                child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[_buildInputRegion()]),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInputRegion() {
    return BlocListener<ForgotPwBloc, ForgotPwState>(
      listener: (BuildContext context, ForgotPwState state) {},
      child: BlocBuilder<ForgotPwBloc, ForgotPwState>(
          builder: (BuildContext context, ForgotPwState state) {
        return Positioned.fill(
            top: 30,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).forgot_email_label,
                        style: TextStyle(
                            color: R.color.text_blue_color(), fontSize: 14),
                        textAlign: TextAlign.left,
                      )),
                  MailField(
                      prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Image(image: R.image.ico_mail_1())),
                      controller: _emailController,
                      hintColor: R.color.hint_color_light_bg(),
                      textColor: R.color.text_blue_color(),
                      validator: (_) {
                        return state is EmailInvalidState
                            ? S.of(context).login_email_error
                            : null;
                      }),
                  SizedBox(height: 30),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).verification_code,
                        style: TextStyle(
                            color: R.color.text_blue_color(), fontSize: 14),
                        textAlign: TextAlign.left,
                      )),
                  _buildVerificationCodeField(),
                  SizedBox(height: 30),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).forgot_pw_label,
                        style: TextStyle(
                            color: R.color.text_blue_color(), fontSize: 14),
                        textAlign: TextAlign.left,
                      )),
                  PasswordField(
                    prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Image(image: R.image.ico_lock_1())),
                    suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: IconButton(
                          icon: Image(
                              image: showPassword
                                  ? R.image.ico_eye_1()
                                  : R.image.ico_eyeslash_1()),
                          onPressed: () {
                            showPassword = !showPassword;
                            setState(() {});
                          },
                        )),
                    obscureText: !showPassword,
                    controller: _passwordController,
                    hintColor: R.color.hint_color_light_bg(),
                    textColor: R.color.text_blue_color(),
                    validator: (_) {
                      return state is PWInvalidState
                          ? S.of(context).login_pw_error
                          : null;
                    },
                  ),
                  SizedBox(height: 40),
                  Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(double.infinity, 44),
                          backgroundColor: R.color.btn_blue_color(),
                          elevation: 5.0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                          ),
                        ),
                        onPressed: () {
                          _forgotPwBloc.add(SubmitEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                              verificationCode:
                                  _verificationCodeController.text));
                        },
                        child: Text(S.of(context).submit,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ))
                ],
              ),
            ));
      }),
    );
  }

  Widget _buildVerificationCodeField() {
    return BlocListener<ForgotPwBloc, ForgotPwState>(
        listener: (BuildContext context, ForgotPwState state) {},
        child: BlocBuilder<ForgotPwBloc, ForgotPwState>(
            builder: (BuildContext context, ForgotPwState state) {
          return Row(
            children: [
              Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _verificationCodeController,
                    maxLength: 20,
                    maxLines: 1,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      counterText: '',
                      prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Image(image: R.image.ico_shieldcheck())),
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 24, maxHeight: 24),
                      hintStyle: TextStyle(
                          color: R.color.hint_color_light_bg(), fontSize: 14),
                      hintText: S.of(context).verification_code_hint,
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
                    style: TextStyle(color: R.color.text_blue_color()),
                    validator: (value) {
                      return state is VerificationCodeInvalidState
                      ? S.of(context).verification_code_error
                          : null;
                    },
                  )),
              Expanded(
                  flex: 1,
                  child: AbsorbPointer(
                      absorbing: state is CodeCountDownState,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(double.infinity, 36),
                          backgroundColor: state is CodeCountDownState
                              ? R.color.background_color()
                              : Colors.white,
                          elevation: 2.0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                          ),
                        ),
                        onPressed: () {
                          if (state is CodeCountDownState) {
                            return;
                          }
                          _forgotPwBloc.add(SendCodeStart());
                        },
                        child: Text(
                            state is CodeCountDownState
                                ? '${state.time.toString()}s...'
                                : S.of(context)
                                    .forgot_pw_send_verification_code,
                            style: TextStyle(
                                color: state is CodeCountDownState
                                    ? R.color.text_blue_color().withAlpha(128)
                                    : R.color.text_blue_color(),
                                fontSize: 14)),
                      )))
            ],
          );
        }));
  }
}
