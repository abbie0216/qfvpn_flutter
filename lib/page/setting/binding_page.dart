import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/setting/binding_bloc.dart';
import 'package:qfvpn/widget/MailField.dart';
import 'package:qfvpn/widget/PasswordField.dart';

import '../../r.dart';
import '../../s.dart';

class BindingPage extends StatefulWidget {
  BindingPage({Key? key}) : super(key: key);

  @override
  _BindingPageState createState() => _BindingPageState();
}

class _BindingPageState extends State<BindingPage> {
  late BindingBloc _bindingBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _invitationCodeController =
      TextEditingController();

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _bindingBloc = BlocProvider.of<BindingBloc>(context);
    // _settingBloc.add(SettingFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BindingBloc, BindingState>(
      listener: (context, state) {},
      child: BlocBuilder<BindingBloc, BindingState>(builder: (context, state) {
        return Scaffold(
            backgroundColor: R.color.background_color(),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(S.of(context).binding_title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: R.color.text_blue_color()),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
              backgroundColor: R.color.background_color(),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(28.0, 0.0, 28.0, 30.0),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[_buildInputRegion()],
              ),
            ));
      }),
    );
  }

  Widget _buildInputRegion() {
    return BlocListener<BindingBloc, BindingState>(
      listener: (BuildContext context, BindingState state) {},
      child: BlocBuilder<BindingBloc, BindingState>(
          builder: (BuildContext context, BindingState state) {
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
                    S.of(context).login_email_label,
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
                  validator: (value) {
                    return state is BindingEmailInvalidState
                        ? S.of(context).login_email_error
                        : null;
                  }),
              SizedBox(height: 30),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    S.of(context).login_pw_label,
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
                  return state is BindingPWInvalidState
                      ? S.of(context).login_pw_error
                      : null;
                },
              ),
              SizedBox(height: 30),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    S.of(context).register_invitation_code_label,
                    style: TextStyle(
                        color: R.color.text_blue_color(), fontSize: 14),
                    textAlign: TextAlign.left,
                  )),
              _buildInvitationCodeField(),
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
                      _bindingBloc.add(SubmitEvent(
                          email: _emailController.text,
                          password: _passwordController.text,
                          invitationCode: _invitationCodeController.text));
                    },
                    child: Text(S.of(context).submit,
                        style: TextStyle(
                            color: Colors.white, fontSize: 16)),
                  ))
            ],
          )),
        );
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
            child: Image(image: R.image.ico_handshake_1())),
        prefixIconConstraints: BoxConstraints(minWidth: 24, maxHeight: 24),
        hintStyle: TextStyle(color: R.color.hint_color_light_bg(), fontSize: 14),
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
      style: TextStyle(color: R.color.text_blue_color()),
      validator: (_) {},
    );
  }
}
