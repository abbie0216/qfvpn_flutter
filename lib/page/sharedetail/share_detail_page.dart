import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/sharedetail/share_detail_bloc.dart';
import 'package:qfvpn/r.dart';
import 'package:qfvpn/s.dart';
import 'package:qfvpn/widget/selector_widget_button.dart';

class ShareDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShareDetailPageState();
}

class _ShareDetailPageState extends State<ShareDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ShareDetailBloc, ShareDetailState>(
        listener: (context, state) {},
        child: BlocBuilder<ShareDetailBloc, ShareDetailState>(
            builder: (context, state) {
          return Theme(
              data: ThemeData(primaryColor: R.color.share_detail_app_bar_bg()),
              child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    leading: SelectorWidgetButton(
                      widgetN: Image(image: R.image.btn_close_n()),
                      widgetP: Image(image: R.image.btn_close_p()),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    centerTitle: true,
                    title: Text(
                      S.of(context).share_detail_title,
                      style: TextStyle(
                          color: R.color.share_detail_title_text(),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  body: SafeArea(
                      child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        buildSummary(),
                        buildRewardDetailTitle(),
                        buildRewardDetail()
                      ],
                    ),
                  ))));
        }));
  }

  Widget buildSummary() {
    return Container(
      color: R.color.share_detail_bg_top(),
      child: Container(
        margin: EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 16),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: R.color.share_detail_summary_bg(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(image: R.image.ico_invite_friends()),
                  Text(
                    '0',
                    style: TextStyle(
                        color: R.color.share_detail_invited_count_text(),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    S.of(context).share_detail_invited_count_hint,
                    style: TextStyle(
                        color: R.color.share_detail_invited_count_hint_text(),
                        fontSize: 12),
                  )
                ],
              ),
            ),
            Container(
              width: 2,
              height: 50,
              color: R.color.share_detail_summary_divider_bg(),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(image: R.image.ico_invite_gift()),
                  Text(
                    '0',
                    style: TextStyle(
                        color: R.color.share_detail_reward_point_text(),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    S.of(context).share_detail_total_reward_point_hint,
                    style: TextStyle(
                        color: R.color.share_detail_reward_point_hint_text(),
                        fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRewardDetailTitle() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 16, bottom: 10),
      child: Text(
        S.of(context).share_detail_total_reward_detail_title,
        style: TextStyle(
            color: R.color.share_detail_reward_detail_title_text(),
            fontSize: 14,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildRewardDetail() {
    return Expanded(
        child: Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 16, right: 16),
      child: IndexedStack(
        index: 1,
        children: [buildEmptyRewardDetailList(), buildRewardDetailList()],
      ),
    ));
  }

  Widget buildEmptyRewardDetailList() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: R.image.img_empty()),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 24),
          child: Text(
            S.of(context).share_detail_no_data_hint,
            style: TextStyle(
                color: R.color.share_detail_reward_detail_no_data_text(),
                fontSize: 14),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.only(
                      left: 45, right: 45, top: 11, bottom: 11)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
                  backgroundColor: MaterialStateProperty.all(
                      R.color.share_detail_invite_imm_btn_bg())),
              onPressed: () {},
              child: Text(
                S.of(context).share_detail_invite_imm_btn,
                style: TextStyle(
                    fontSize: 16,
                    color: R.color.share_detail_invite_imm_btn_text(),
                    fontWeight: FontWeight.w500),
              )),
        )
      ],
    );
  }

  Widget buildRewardDetailList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                  color: R.color.share_detail_reward_detail_item_border(),
                  width: 1)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '2018-03-20 20:20',
                      style: TextStyle(
                          color:
                          R.color.share_detail_reward_detail_item_time_text(),
                          fontSize: 12),
                    ),
                  ),
                  Container(height: 4,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('xi**dong@163.com',
                        style: TextStyle(
                            color: R.color
                                .share_detail_reward_detail_item_name_text(),
                            fontSize: 14)),
                  ),
                ],
              )),
              Text(
                '+10',
                style: TextStyle(
                    fontSize: 14,
                    color: R.color.share_detail_reward_detail_item_point_text(),
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        );
      }
    );
  }
}
