import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/bloc/feedback/feedback_detail_bloc.dart';
import 'package:qfvpn/bloc/feedback/feedback_detail_event.dart';
import 'package:qfvpn/bloc/feedback/feedback_detail_state.dart';
import 'package:qfvpn/model/api/bean/feedback/detail_resp.dart';
import 'package:qfvpn/utility/convert.dart';

import '../../r.dart';
import '../../s.dart';

class FeedbackDetailPage extends StatefulWidget {
  FeedbackDetailPage({Key? key}) : super(key: key);

  @override
  _FeedbackDetailState createState() => _FeedbackDetailState();
}

class _FeedbackDetailState extends State<FeedbackDetailPage> {
  late FeedbackDetailBloc _feedbackDetailBloc;
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _feedbackDetailBloc = BlocProvider.of<FeedbackDetailBloc>(context);
    Future.delayed(Duration.zero, () {
      dynamic obj = ModalRoute.of(context)!.settings.arguments;
      var feedbackId = obj['feedbackId']; // 把接收到的參數存到變數
      _feedbackDetailBloc.add(FetchDetailEvent(feedbackId));
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedbackDetailBloc, FeedbackDetailState>(
      listener: (context, state) {
        if (state is InitState) {
        } else if (state is DetailLoadedState) {}
      },
      child: BlocBuilder<FeedbackDetailBloc, FeedbackDetailState>(
          builder: (context, state) {
        return Scaffold(
          backgroundColor: R.color.background_color(),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(S.of(context).feedback_detail_title,
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
          body: _buildBody(context, state),
        );
      }),
    );
  }

  Widget _buildBody(BuildContext context, FeedbackDetailState state) {
    if (state is InitState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is DetailLoadedState) {
      var item = state.result;
      return ListView(
        children: [
          _buildFeedbackItem(false, item),
          SizedBox(height: 10),
          _buildReplyList(item),
          SizedBox(height: 10),
          _buildReplyWidget(item),
          _buildSatisfactionWidget(item),
        ],
      );
    } else {
      return Center(child: Text('Unknown state'));
    }
  }

  Widget _buildFeedbackItem(bool isCS, DetailResp item) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFeedbackType(item.categoryName),
          SizedBox(height: 10),
          _buildContentWidget(item.content),
          SizedBox(height: 10),
          _buildImageList(item.images),
          SizedBox(height: 20),
          _buildTimeItem(
              feedbackDateTimeDisplay(item.createdAt.toIso8601String())),
        ],
      ),
    );
  }

  Widget _buildFeedbackType(String type) {
    return Text(type,
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold));
  }

  Widget _buildContentWidget(String content) {
    return Text(
      content,
      textAlign: TextAlign.start,
      style: TextStyle(color: R.color.text_color_alpha80(), fontSize: 14),
    );
  }

  Widget _buildImageList(List<dynamic> images) {
    return Visibility(
      visible: images.isNotEmpty,
      child: Container(
        height: 80,
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => _buildImageItem(images[index]),
          itemCount: images.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              indent: 10,
              color: Colors.transparent,
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageItem(dynamic image) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: R.color.background_color(),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        // fit: BoxFit.fill,
      ),
      child: Image(image: R.image.img_earnpoint()),
    );
  }

  Widget _buildTimeItem(String time) {
    return Text(
      time,
      style: TextStyle(color: R.color.text_color_alpha50(), fontSize: 12),
    );
  }

  Widget _buildReplyList(DetailResp item) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) => _buildReplyItem(item.replies[index]),
      itemCount: item.replies.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          indent: 10,
          color: Colors.transparent,
        );
      },
    );
  }

  Widget _buildReplyItem(Reply item) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReplyTitle(item),
          SizedBox(height: 10),
          _buildContentWidget(item.content),
          SizedBox(height: 10),
          _buildImageList(item.attachments),
          SizedBox(height: 10),
          _buildTimeItem(
              feedbackDateTimeDisplay(item.createdAt.toIso8601String())),
        ],
      ),
    );
  }

  Widget _buildReplyTitle(Reply item) {
    return Visibility(
      visible: true, //確認: 如何判斷是否為op
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: R.image.img_service()),
          SizedBox(width: 8),
          Text(item.opName,
              style: TextStyle(
                  color: R.color.text_blue_color(),
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSatisfactionWidget(DetailResp item) {
    return Visibility(
      visible: item.isCanSurvey,
      child: Container(
        height: 80,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            Expanded(
                child: _buildSatisfactionItem(R.image.btn_notgood_n(),
                    S.of(context).feedback_detail_not_satisfied, false)),
            _buildDivider(),
            Expanded(
                child: _buildSatisfactionItem(R.image.btn_soso_n(),
                    S.of(context).feedback_detail_average, false)),
            _buildDivider(),
            Expanded(
                child: _buildSatisfactionItem(R.image.btn_sogood_n(),
                    S.of(context).feedback_detail_satisfied, true)),
          ],
        ),
      ),
    );
  }

  Widget _buildSatisfactionItem(ImageProvider ip, String s, bool isSelect) {
    var imgColor = isSelect
        ? R.color.feedback_satisfaction_select()
        : R.color.text_color_alpha30();
    var textColor = isSelect
        ? R.color.feedback_satisfaction_select()
        : R.color.text_color_alpha50();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Image(image: ip, color: imgColor)),
        SizedBox(height: 6),
        Expanded(
          child: Text(
            s,
            style: TextStyle(color: textColor, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 2,
      color: R.color.background_color(),
    );
  }

  Widget _buildReplyWidget(DetailResp item) {
    return Visibility(
      visible: item.isCanSurvey,
      child: Row(
        children: [
          _buildCameraBtn(),
          Expanded(child: _buildInputWidget()),
        ],
      ),
    );
  }

  Widget _buildCameraBtn() {
    return Container(
      height: 42,
      width: 42,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      child: Center(child: Image(image: R.image.btn_camera_n())),
    );
  }

  Widget _buildInputWidget() {
    return Container(
      height: 42,
      margin: EdgeInsets.only(left: 6, right: 10),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTextField()),
          _buildSubmitBtn(textController.text.length >= 2),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: S.of(context).feedback_detail_reply_hint,
        hintStyle: TextStyle(color: R.color.text_color_alpha30(), fontSize: 14),
      ),
      controller: textController,
    );
  }

  Widget _buildSubmitBtn(bool visible) {
    return Visibility(
      visible: visible,
      child: TextButton(
        onPressed: () => _onSubmitPressed(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 30,
          decoration: BoxDecoration(
            color: R.color.feedback_submit_btn_bg(),
            borderRadius: BorderRadius.all(Radius.circular(22)),
            // fit: BoxFit.fill,
          ),
          child: Center(
            child: Text(
              S.of(context).feedback_detail_reply_send,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmitPressed() {
    Fimber.d('@@input ${textController.text}');
  }
}
