import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:qfvpn/bloc/feedback/feedback_bloc.dart';
import 'package:qfvpn/bloc/feedback/feedback_event.dart';
import 'package:qfvpn/bloc/feedback/feedback_state.dart';
import 'package:qfvpn/constants.dart';
import 'package:qfvpn/model/api/bean/feedback/feedback_list_resp.dart';
import 'package:qfvpn/page/feedback/add_feedback_page.dart';
import 'package:qfvpn/page/feedback/feedback_detail_page.dart';

import '../../r.dart';
import '../../s.dart';

class FeedbackListPage extends StatefulWidget {
  FeedbackListPage({Key? key}) : super(key: key);

  @override
  _FeedbackListState createState() => _FeedbackListState();
}

class _FeedbackListState extends State<FeedbackListPage> {
  late FeedbackBloc _feedbackBloc;
  FeedbackListResp? _feedbackListResp;

  var _pageKey;
  final PagingController<int, FeedbackItem> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _feedbackBloc = BlocProvider.of<FeedbackBloc>(context);
    _pagingController.addPageRequestListener((pageKey) {
      _pageKey = pageKey;
      _feedbackBloc.add(FetchFeedbackEvent(pageKey));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedbackBloc, FeedbackState>(
      listener: (context, state) {
        if (state is FeedbackInitState) {

        } else if(state is LoadedState) {
          _feedbackListResp = state.result;
          var newItems = state.result.items;
          final isLastPage = newItems.length < PAGE_SIZE;
          if (isLastPage) {
            _pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = ++_pageKey;
            _pagingController.appendPage(newItems, nextPageKey);
          }
        }
      },
      child:
          BlocBuilder<FeedbackBloc, FeedbackState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: R.color.background_color(),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(S.of(context).feedback_list_title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon:
                  Icon(Icons.arrow_back_ios, color: R.color.text_blue_color()),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed((AddFeedbackPage).toString()),
                  child: Text(
                    S.of(context).add_feedback_title,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            ],
            elevation: 0,
            backgroundColor: R.color.background_color(),
            centerTitle: true,
          ),
          body: RefreshIndicator(
              onRefresh: () => Future.sync(
                    () => _pagingController.refresh(),
              ),
              child: PagedListView<int, FeedbackItem>.separated(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<FeedbackItem>(
                  itemBuilder: (context, item, index) => _buildListItem(context, index)
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 10,
                    color: Colors.transparent,
                  );
                },
              ),
          )
        );
      }),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed((FeedbackDetailPage).toString()),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          // fit: BoxFit.fill,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 16),
                _buildTimeItem(),
                Spacer(),
                _buildFlag(context, index % 3 == 0),
              ],
            ),
            _buildDivider(),
            _buildFeedbackTitle(),
            SizedBox(height: 2),
            _buildFeedbackContent(),
            SizedBox(height: 12),
            _buildResponse(context, index % 3 == 0),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeItem() {
    return Text(
      '2018-03-20 20:20',
      style: TextStyle(color: R.color.text_color_alpha50(), fontSize: 12),
    );
  }

  Widget _buildFlag(BuildContext context, bool solved) {
    var bg =
        solved ? R.color.feedback_solved_flag_bg() : R.color.feedback_submit_flag_bg();
    var str =
        solved ? S.of(context).feedback_solved : S.of(context).feedback_submit;
    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 4, left: 14, right: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
        // fit: BoxFit.fill,
      ),
      child: Text(
        str,
        style: TextStyle(color: R.color.btn_white_color(), fontSize: 12),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      height: 1,
      color: R.color.background_color(),
    );
  }

  Widget _buildFeedbackTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text('反馈标题',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildFeedbackContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '文字内容文字内容文字内容文字字内容文文字内容文字内容文字内容文字字内容文文字内容文字内容文字内容文字字内容文',
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(color: R.color.text_color_alpha80(), fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildResponse(BuildContext context, bool solved) {
    return Visibility(
      visible: solved,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: R.color.background_color(),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          // fit: BoxFit.fill,
        ),
        child: Text(
          '文字内容文字内容文字内容文字字内容文文字内容文字内容文字内容文字字内容文文字内容文字内容文字内容文字字内容文',
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(color: R.color.text_color_alpha50(), fontSize: 14),
        ),
      ),
    );
  }
}
