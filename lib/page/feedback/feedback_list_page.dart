import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/feedback/feedback_bloc.dart';
import 'package:qfvpn/bloc/feedback/feedback_state.dart';

import '../../r.dart';
import '../../s.dart';

class FeedbackListPage extends StatefulWidget {
  FeedbackListPage({Key? key}) : super(key: key);

  @override
  _FeedbackListState createState() => _FeedbackListState();
}

class _FeedbackListState extends State<FeedbackListPage> {
  late FeedbackBloc _feedbackBloc;

  @override
  void initState() {
    super.initState();
    _feedbackBloc = BlocProvider.of<FeedbackBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedbackBloc, FeedbackState>(
      listener: (context, state) {
        if (state is FeedbackInitState) {}
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
            elevation: 0,
            backgroundColor: R.color.background_color(),
            centerTitle: true,
          ),
          body: ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            itemBuilder: _buildListItem,
            itemCount: 30,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 10,
                color: Colors.transparent,
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {},
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
                Text(
                  '2018-03-20 20:20',
                  style: TextStyle(
                      color: R.color.text_color_alpha50(), fontSize: 12),
                ),
                Spacer(),
                _buildFlag(context, index % 3 == 0),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              height: 1,
              color: R.color.background_color(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('反馈标题',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '文字内容文字内容文字内容文字字内容文文字内容文字内容文字内容文字字内容文文字内容文字内容文字内容文字字内容文',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: R.color.text_color_alpha80(), fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlag(BuildContext context, bool solved) {
    var bg = solved ? R.color.feedback_solved_bg() : R.color.feedback_submit_bg();
    var str = solved ? S.of(context).feedback_solved : S.of(context).feedback_submit;
    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 4, left: 14, right: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
        // fit: BoxFit.fill,
      ),
      child: Text(
        str,
        style: TextStyle(
            color: R.color.btn_white_color(), fontSize: 12),
      ),
    );
  }
}
