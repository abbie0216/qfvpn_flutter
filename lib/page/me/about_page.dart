import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/me/about/about_bloc.dart';

import '../../r.dart';
import '../../s.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late AboutBloc _aboutBloc;

  @override
  void initState() {
    super.initState();
    _aboutBloc = BlocProvider.of<AboutBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AboutBloc, AboutState>(
      listener: (context, state) {},
      child: BlocBuilder<AboutBloc, AboutState>(builder: (context, state) {
        return Scaffold(
            backgroundColor: R.color.background_color(),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(S.of(context).about_page_title,
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
            body: _buildContentView());
      }),
    );
  }

  Widget _buildContentView() {
    return BlocListener<AboutBloc, AboutState>(
        listener: (context, state) {},
        child: BlocBuilder<AboutBloc, AboutState>(builder: (context, state) {
          return Column(
            children: [
              Divider(height: 30, color: Colors.transparent),
              Text(S.of(context).app_name,
                  style: TextStyle(
                      color: R.color.text_blue_color(), fontSize: 18)),
              Text('v1.3.0',
                  style: TextStyle(
                      color: R.color.text_gray_color(), fontSize: 12)),
              Divider(height: 30, color: Colors.transparent),
              Row(mainAxisSize: MainAxisSize.max, children: [
                Spacer(),
                TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(130, 44),
                      backgroundColor: R.color.btn_blue_color(),
                      elevation: 2.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                        children: [
                      Text(S.of(context).about_contact_us,
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      Image(image: R.image.btn_next_white_n())
                    ])),
                Spacer(),
                TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(130, 44),
                      backgroundColor: R.color.btn_blue_color(),
                      elevation: 2.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(children: [
                      Text(S.of(context).about_to_web,
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      Image(image: R.image.btn_next_white_n())
                    ])),
                Spacer(),
              ]),
              Divider(height: 30, color: Colors.transparent),
              _buildItemsRegion()
            ],
          );
        }));
  }

  Widget _buildItemsRegion() {
    return BlocListener<AboutBloc, AboutState>(
        listener: (context, state) {},
        child: BlocBuilder<AboutBloc, AboutState>(builder: (context, state) {
          return Align(
              alignment: FractionalOffset(0.0, 0.6),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(height: 14),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 16),
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
                              // Navigator.of(context)
                              //     .pushNamed((NewsPage).toString());
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        S.of(context).about_item_privacy_policy,
                                        style: TextStyle(
                                            color: R.color.text_gray_color()))),
                                Image(
                                  image: R.image.btn_next_n(),
                                )
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
                            onTap: () {},
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        S.of(context).about_item_user_agreement,
                                        style: TextStyle(
                                            color: R.color.text_gray_color()))),
                                Image(
                                  image: R.image.btn_next_n(),
                                )
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
                              Navigator.pushNamed(
                                  context, (AboutPage).toString());
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        S.of(context).about_item_app_score,
                                        style: TextStyle(
                                            color: R.color.text_gray_color()))),
                                Image(
                                  image: R.image.btn_next_n(),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                )
              ]));
        }));
  }
}
