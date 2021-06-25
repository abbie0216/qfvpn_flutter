
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/setting/pw_change_bloc.dart';
import 'package:qfvpn/widget/PasswordField.dart';

import '../../r.dart';
import '../../s.dart';

class PwChangePage extends StatefulWidget {
  PwChangePage({Key? key}) : super(key: key);

  @override
  _PwChangePageState createState() => _PwChangePageState();
}

class _PwChangePageState extends State<PwChangePage> {
  late PwChangeBloc _pwChangeBloc;

  final TextEditingController _orgPwController = TextEditingController();
  final TextEditingController _newPwController = TextEditingController();

  bool showPasswordOrg = false;
  bool showPasswordNew = false;

  @override
  void initState() {
    super.initState();
    _pwChangeBloc = BlocProvider.of<PwChangeBloc>(context);

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PwChangeBloc, PwChangeState>(
      listener: (context, state) {

      },
      child: BlocBuilder<PwChangeBloc, PwChangeState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: R.color.background_color(),
          appBar: AppBar(
            title: Text(S.of(context).pw_change_title,
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
    return BlocListener<PwChangeBloc, PwChangeState>(
      listener: (BuildContext context, PwChangeState state) {},
      child: BlocBuilder<PwChangeBloc, PwChangeState>(
          builder: (BuildContext context, PwChangeState state) {
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
                            S.of(context).original_password,
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
                                  image: showPasswordOrg
                                      ? R.image.ico_eye_1()
                                      : R.image.ico_eyeslash_1()),
                              onPressed: () {
                                showPasswordOrg = !showPasswordOrg;
                                setState(() {});
                              },
                            )),
                        obscureText: !showPasswordOrg,
                        controller: _orgPwController,
                        hintColor: R.color.hint_color_light_bg(),
                        textColor: R.color.text_blue_color(),
                        validator: (_) {
                          return state is OrgPWInvalidState
                              ? S.of(context).login_pw_error
                              : null;
                        },
                      ),
                      SizedBox(height: 30),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            S.of(context).new_password,
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
                                  image: showPasswordNew
                                      ? R.image.ico_eye_1()
                                      : R.image.ico_eyeslash_1()),
                              onPressed: () {
                                showPasswordNew = !showPasswordNew;
                                setState(() {});
                              },
                            )),
                        obscureText: !showPasswordNew,
                        controller: _newPwController,
                        hintColor: R.color.hint_color_light_bg(),
                        textColor: R.color.text_blue_color(),
                        validator: (_) {
                          return state is NewPWInvalidState
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
                              _pwChangeBloc.add(SubmitEvent(
                                  orgPassword: _orgPwController.text,
                                  newPassword: _newPwController.text));
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
}
