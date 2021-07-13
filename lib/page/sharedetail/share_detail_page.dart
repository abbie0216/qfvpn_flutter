import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:qfvpn/bloc/sharedetail/share_detail_bloc.dart';
import 'package:qfvpn/model/api/bean/invite/invite_info_resp.dart';
import 'package:qfvpn/model/api/bean/invite/invite_list_resp.dart';
import 'package:qfvpn/r.dart';
import 'package:qfvpn/s.dart';
import 'package:qfvpn/widget/selector_widget_button.dart';

import '../../constants.dart';

class ShareDetailPage extends StatefulWidget {
  final InviteInfoResp inviteInfo;

  ShareDetailPage(this.inviteInfo);

  @override
  State<StatefulWidget> createState() => _ShareDetailPageState();
}

class _ShareDetailPageState extends State<ShareDetailPage> {
  late ShareDetailBloc _shareDetailBloc;

  var _pageKey;
  final PagingController<int, InviteItem> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _shareDetailBloc = BlocProvider.of<ShareDetailBloc>(context);
    _pagingController.addPageRequestListener((pageKey) {
      _pageKey = pageKey;
      _shareDetailBloc.add(FetchListEvent(pageKey));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShareDetailBloc, ShareDetailState>(
        listener: (context, state) {
      if (state is LoadedState) {
        var newItems = state.result.items ?? <InviteItem>[];
        final isLastPage = newItems.length < PAGE_SIZE;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = ++_pageKey;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      }
    }, child: BlocBuilder<ShareDetailBloc, ShareDetailState>(
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
                    _buildSummary(),
                    _buildRewardDetailTitle(),
                    Expanded(
                        child: RefreshIndicator(
                      onRefresh: () => Future.sync(
                        () => _pagingController.refresh(),
                      ),
                      child: PagedListView<int, InviteItem>.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                        pagingController: _pagingController,
                        builderDelegate: PagedChildBuilderDelegate<InviteItem>(
                            itemBuilder: (context, item, index) =>
                                _buildItemList(item),
                            noItemsFoundIndicatorBuilder: (_) =>
                                _buildEmptyList(),
                            // noMoreItemsIndicatorBuilder: (_) =>
                            //     _buildNoMoreItemsIndicator(),
                            ),
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 8,
                            color: Colors.transparent,
                          );
                        },
                      ),
                    ))
                  ],
                ),
              ))));
    }));
  }

  Widget _buildSummary() {
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
                    '${widget.inviteInfo.inviteCount ?? '0'}',
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
                    '${widget.inviteInfo.totalPoint ?? '0'}',
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

  Widget _buildRewardDetailTitle() {
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

  Widget _buildItemList(InviteItem item) {
    return Container(
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
                  DateFormat('yyyy-MM-dd hh:mm')
                      .format(item.inviteAt ?? DateTime.now()),
                  style: TextStyle(
                      color:
                          R.color.share_detail_reward_detail_item_time_text(),
                      fontSize: 12),
                ),
              ),
              Container(
                height: 4,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(item.email ?? '',
                    style: TextStyle(
                        color:
                            R.color.share_detail_reward_detail_item_name_text(),
                        fontSize: 14)),
              ),
            ],
          )),
          Text(
            '+${item.point}',
            style: TextStyle(
                fontSize: 14,
                color: R.color.share_detail_reward_detail_item_point_text(),
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _buildEmptyList() {
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

  Widget _buildNoMoreItemsIndicator() {
    return Padding(
      padding: EdgeInsets.only(top: 40, bottom: 20),
      child: Center(
        child: Text(
          S.of(context).feedback_list_end,
          style: TextStyle(color: R.color.text_color_alpha30(), fontSize: 12),
        ),
      ),
    );
  }
}
