import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qfvpn/widget/selector_widget_button.dart';

import '../../r.dart';
import '../../s.dart';

class PayResultPage extends StatelessWidget {
  final bool isSuccess;

  PayResultPage({required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: R.color.pay_result_app_bar_bg()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            isSuccess
                ? S.of(context).pay_result_success
                : S.of(context).pay_result_failed,
            style: TextStyle(
                fontSize: 16,
                color: R.color.pay_result_title_text(),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: SelectorWidgetButton(
            widgetN: Image(image: R.image.btn_back_n()),
            widgetP: Image(image: R.image.btn_back_p()),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            color: R.color.pay_result_bg(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 80, bottom: 10),
                  child: Image(
                    image:
                        isSuccess ? R.image.img_success() : R.image.img_fill(),
                  ),
                ),
                Text(
                  isSuccess
                      ? S.of(context).pay_result_success
                      : S.of(context).pay_result_failed,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: R.color.pay_result_main_text()),
                ),
                buildFailHint(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              R.color.pay_result_back_btn_splash()),
                          fixedSize: MaterialStateProperty.all(Size(155, 44)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22)))),
                          side: MaterialStateProperty.all(BorderSide(
                              color: R.color.pay_result_back_btn_border()))),
                      child: Text(
                        S.of(context).pay_result_to_home_btn,
                        style: TextStyle(
                            fontSize: 16,
                            color: R.color.pay_result_back_btn_text(),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(isSuccess) {
                          //todo check order
                        }else{
                          Navigator.of(context).pop();
                        }
                      },
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(1),
                          backgroundColor: MaterialStateProperty.all(
                              R.color.pay_result_next_btn_bg()),
                          fixedSize: MaterialStateProperty.all(Size(155, 44)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22))))),
                      child: Text(
                        isSuccess
                            ? S.of(context).pay_result_check_order_btn
                            : S.of(context).pay_result_retry_btn,
                        style: TextStyle(
                            fontSize: 16,
                            color: R.color.pay_result_next_btn_text(),
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFailHint(context) {
    return isSuccess
        ? Container(
            height: 70,
          )
        : Padding(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: Text(
              S.of(context).pay_result_failed_hint,
              style:
                  TextStyle(fontSize: 14, color: R.color.pay_result_sub_text()),
            ),
          );
  }
}
