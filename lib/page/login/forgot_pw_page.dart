import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/login/forgot_pw_bloc.dart';

import '../../r.dart';
import '../../s.dart';
import '../login/login_page.dart';

class ForgotPwPage extends StatefulWidget {
  ForgotPwPage({Key? key}) : super(key: key);

  @override
  _ForgotPwPageState createState() => _ForgotPwPageState();
}

class _ForgotPwPageState extends State<ForgotPwPage> {
  late ForgotPwBloc _forgotPwBloc;

  @override
  void initState() {
    super.initState();
    _forgotPwBloc = BlocProvider.of<ForgotPwBloc>(context);
    // Future.delayed(const Duration(seconds: 2), () {
    //   _forgotPwBloc.add(ForgotPwFetchEvent());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPwBloc, ForgotPwState>(
      listener: (context, state) {
        // if (state is ForgotPwLoadedState) {
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext pageContext) => LoginPage()));
        // }
      },
      child:
          BlocBuilder<ForgotPwBloc, ForgotPwState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: R.color.background_color(),
          appBar: AppBar(
            title: Text(S.of(context).login_forget_pw,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: R.color.text_blue_color()),
              onPressed: () => Navigator.of(context).pop(),
            ),
            elevation: 0,
            backgroundColor: R.color.background_color(),
            centerTitle: true,
          ),
          body: Stack(
            children: <Widget>[],
          ),
        );
      }),
    );
  }
}
