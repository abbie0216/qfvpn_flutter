import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/login/register_bloc.dart';

import '../../r.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    // Future.delayed(const Duration(seconds: 2), () {
    //   _RegisterBloc.add(RegisterFetchEvent());
    // });

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc,RegisterState>(
      listener: (context, state) {
        // if (state is RegisterLoadedState) {
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext pageContext) => LoginPage()));
        // }
      },
      child: BlocBuilder<RegisterBloc,RegisterState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: R.color.login_bg_color(),
          resizeToAvoidBottomInset:false,
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

                ]),
              )
            ],
          ),
        );
      }),
    );
  }
}
