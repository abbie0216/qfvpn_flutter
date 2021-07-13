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
  late var _feedbackId;
  DetailResp? _detailResp;
  final _textController = TextEditingController();
  bool _submitBtnVisible = false;

  @override
  void initState() {
    super.initState();
    _feedbackDetailBloc = BlocProvider.of<FeedbackDetailBloc>(context);
    Future.delayed(Duration.zero, () {
      dynamic obj = ModalRoute.of(context)!.settings.arguments;
      _feedbackId = obj['feedbackId']; // 把接收到的參數存到變數
      _feedbackDetailBloc.add(FetchDetailEvent(_feedbackId));
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedbackDetailBloc, FeedbackDetailState>(
      listener: (context, state) {
        if (state is InitState) {
          _showLoadingDialog();
        } else if (state is LoadingState) {
          _showLoadingDialog();
        }  else if (state is LoadedState) {
          Navigator.pop(context);
        } else if (state is DetailLoadedState) {
          _detailResp = state.result;
        } else if (state is DetailErrorState) {
          _showSnakeBar('Detail loaded error: ${state.error}');
        } else if (state is CreateReplySuccessState) {
          _showSnakeBar('Reply success.');
        } else if (state is CreateReplyErrorState) {
          _showSnakeBar('Reply error: ${state.error}');
        } else if (state is TakeSurveySuccessState) {
          _showSnakeBar('Take survey success.');
        } else if (state is TakeSurveyErrorState) {
          _showSnakeBar('Take survey error: ${state.error}');
        }
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
          body: _buildBody(),
        );
      }),
    );
  }

  Widget _buildBody() {
    if (_detailResp != null) {
      return ListView(
        children: [
          _buildFeedbackItem(false, _detailResp!),
          SizedBox(height: 10),
          _buildReplyList(_detailResp!),
          SizedBox(height: 10),
          _buildReplyWidget(_detailResp!),
          _buildSatisfactionWidget(_detailResp!),
        ],
      );
    } else {
      return Container();
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

  Widget _buildImageList(List<Attachment> images) {
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

  ///
  /// 0. 原图
  /// 什么都不加返回的就是原图地址，
  ///
  /// 1. 限制高度
  /// 限制高度 200 Pixel
  /// https://qfvpn.com/files/app-files/91f4d48343da45e361327daadf68c7f9.png?imageView2/0/h/200
  ///
  /// 2. 限制宽度
  /// 限制宽度 200 Pixel
  /// https://qfvpn.com/files/app-files/91f4d48343da45e361327daadf68c7f9.png?imageView2/0/w/200
  ///
  /// 3. 同时限制宽度和高度
  /// 高度宽度设置限制为 200 x 200
  /// https://qfvpn.com/files/app-files/91f4d48343da45e361327daadf68c7f9.png?imageView2/0/w/200/h/200
  ///
  Widget _buildImageItem(Attachment image) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: R.color.background_color(),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        // fit: BoxFit.fill,
      ),
      child: Image.network('${image.url}?imageView2/0/w/200'),
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
      visible: item.type == 2, //確認: 如何判斷是否為op
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
                child: _buildSatisfactionItem(
                    1,
                    R.image.btn_notgood_n(),
                    S.of(context).feedback_detail_not_satisfied,
                    item.surveyScore == 1)),
            _buildDivider(),
            Expanded(
                child: _buildSatisfactionItem(
                    2,
                    R.image.btn_soso_n(),
                    S.of(context).feedback_detail_average,
                    item.surveyScore == 2)),
            _buildDivider(),
            Expanded(
                child: _buildSatisfactionItem(
                    3,
                    R.image.btn_sogood_n(),
                    S.of(context).feedback_detail_satisfied,
                    item.surveyScore == 3)),
          ],
        ),
      ),
    );
  }

  Widget _buildSatisfactionItem(
      int index, ImageProvider ip, String s, bool isSelect) {
    var imgColor = isSelect
        ? R.color.feedback_satisfaction_select()
        : R.color.text_color_alpha30();
    var textColor = isSelect
        ? R.color.feedback_satisfaction_select()
        : R.color.text_color_alpha50();
    return GestureDetector(
      onTap: () => _onSurveyPressed(index),
      child: Column(
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
      ),
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
          _buildSubmitBtn(_submitBtnVisible),
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
      onChanged: (text) => setState(() {
        _submitBtnVisible = text.length >= 2;
      }),
      controller: _textController,
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

  void _onSurveyPressed(int voteNumber) {
    Fimber.d('@@voteNumber: $voteNumber');
    _feedbackDetailBloc.add(TakeSurveyEvent(_feedbackId, voteNumber));
  }

  void _onSubmitPressed() {
    Fimber.d('@@input: ${_textController.text}');
    _feedbackDetailBloc
        .add(CreateReplyEvent(_feedbackId, _textController.text, []));
  }

  void _showSnakeBar(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(msg),
        ],
      )));
  }

  void _showLoadingDialog() {
    var alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text('Loading...')),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
