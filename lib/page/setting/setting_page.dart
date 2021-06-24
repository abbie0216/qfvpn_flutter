import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/setting/pw_change_bloc.dart';
import 'package:qfvpn/bloc/setting/setting_bloc.dart';
import 'package:qfvpn/page/setting/pw_change_page.dart';

import '../../r.dart';
import '../../s.dart';
import 'binding_page.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late SettingBloc _settingBloc;

  @override
  void initState() {
    super.initState();
    _settingBloc = BlocProvider.of<SettingBloc>(context);
    // _settingBloc.add(SettingFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {},
      child: BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: R.color.background_color(),
          appBar: AppBar(
            title: Text(S.of(context).setting_title,
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
              _buildItemsRegion(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildItemsRegion() {
    return BlocListener<SettingBloc, SettingState>(
        listener: (context, state) {},
        child:
            BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
          return Align(
              alignment: FractionalOffset(0.0, 0.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 48,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed((BindingPage).toString());
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image(image: R.image.ico_mail_1())),
                                Expanded(
                                    flex: 5,
                                    child: Text(S.of(context).setting_item_mail,
                                        style: TextStyle(
                                            color: R.color.text_gray_color()))),
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                        S.of(context).setting_item_hint_binding,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: R.color.text_blue_color()))),
                                Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: R.image.btn_next_n(),
                                    ))
                              ],
                            )),
                      ),
                      Divider(
                        color: R.color.background_color(),
                        thickness: 1.0,
                        height: 1,
                      ),
                      SizedBox(
                        height: 48,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed((PwChangePage).toString());
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: R.image.ico_lock_1(),
                                    )),
                                Expanded(
                                    flex: 10,
                                    child: Text(S.of(context).pw_change_title,
                                        style: TextStyle(
                                            color: R.color.text_gray_color()))),
                                Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: R.image.btn_next_n(),
                                    ))
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(28, 40, 28, 0),
                    height: 44,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: R.color.btn_blue_color()),
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),
                    child: OutlinedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: R.color.background_color(),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(S.of(context).btn_logout,
                            style: TextStyle(
                                color: R.color.text_blue_color(),
                                fontWeight: FontWeight.bold,
                                fontSize: 14)))),
              ]));
        }));
  }
}
