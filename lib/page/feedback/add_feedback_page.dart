import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qfvpn/bloc/feedback/add_feedback_bloc.dart';
import 'package:qfvpn/bloc/feedback/add_feedback_event.dart';
import 'package:qfvpn/bloc/feedback/add_feedback_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qfvpn/page/feedback/feedback_type_bottom_sheet.dart';

import '../../r.dart';
import '../../s.dart';

class AddFeedbackPage extends StatefulWidget {
  AddFeedbackPage({Key? key}) : super(key: key);

  @override
  _AddFeedbackState createState() => _AddFeedbackState();
}

class _AddFeedbackState extends State<AddFeedbackPage> {
  late AddFeedbackBloc _addFeedbackBloc;

  int? _feedbackTypeIndex;

  final textController = TextEditingController();
  int letterCount = 0;

  final _picker = ImagePicker();
  List<PickedFile> _imageFileList = <PickedFile>[];

  @override
  void initState() {
    super.initState();
    _addFeedbackBloc = BlocProvider.of<AddFeedbackBloc>(context);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFeedbackBloc, AddFeedbackState>(
      listener: (context, state) {
        if (state is InitState) {
        } else if (state is LoadingState) {
          _showLoadingDialog();
        } else if (state is LoadedState) {
          Navigator.pop(context);
        } else if (state is CreateSuccessState) {
          _showSnakeBar('Create success.');
          Navigator.of(context).pop();
        } else if (state is CreateErrorState) {
          _showSnakeBar('Create error: ${state.error}');
        }
      },
      child: BlocBuilder<AddFeedbackBloc, AddFeedbackState>(
          builder: (context, state) {
        return Scaffold(
          backgroundColor: R.color.background_color(),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(S.of(context).add_feedback_title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon: Icon(Icons.close, color: R.color.text_blue_color()),
              onPressed: () => Navigator.of(context).pop(),
            ),
            elevation: 0,
            backgroundColor: R.color.background_color(),
            centerTitle: true,
          ),
          body: _buildBody(context),
        );
      }),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          _buildSelectTypeItem(context),
          SizedBox(height: 10),
          _buildInputItem(context),
          SizedBox(height: 10),
          _buildImageUploadItem(),
          _buildSubmitBtn(),
        ],
      ),
    );
  }

  Widget _buildSelectTypeItem(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFeedbackTypeBottomSheet(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          // fit: BoxFit.fill,
        ),
        child: Row(
          children: [
            Text(
              S.of(context).add_feedback_type,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            SizedBox(width: 14),
            Text(
              _feedbackTypeIndex == null
                  ? S.of(context).add_feedback_select
                  : _getFeedbackType(_feedbackTypeIndex ?? 0),
              style: TextStyle(
                  color: _feedbackTypeIndex == null
                      ? R.color.text_color_alpha30()
                      : R.color.text_color_alpha80(),
                  fontSize: 14),
            ),
            Spacer(),
            Image(image: R.image.btn_dropdown_n()),
          ],
        ),
      ),
    );
  }

  Widget _buildInputItem(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        // fit: BoxFit.fill,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).add_feedback_input_title,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          Expanded(
            child: TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: S.of(context).add_feedback_input_hint,
                hintStyle: TextStyle(
                    color: R.color.text_color_alpha30(), fontSize: 14),
              ),
              onChanged: (text) => setState(() {
                letterCount = text.length;
              }),
              controller: textController,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              S.of(context).add_feedback_typed + ' $letterCount / 200',
              style:
                  TextStyle(color: R.color.text_color_alpha30(), fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadItem() {
    return Container(
      height: 140,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        // fit: BoxFit.fill,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).add_feedback_upload_hint,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildImageList(),
                _buildAddImageItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageList() {
    var size = _imageFileList.length;
    return ListView.separated(
      padding: EdgeInsets.only(right: size == 0 ? 0 : 10),
      shrinkWrap: true,
      itemBuilder: _buildImageItem,
      itemCount: size,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          indent: 10,
          color: Colors.transparent,
        );
      },
    );
  }

  Widget _buildImageItem(BuildContext context, int index) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: R.color.background_color(),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        // fit: BoxFit.fill,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(File(_imageFileList[index].path),
                fit: BoxFit.cover, width: 80, height: 80),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () => setState(() {
                _imageFileList.removeAt(index);
              }),
              child: Image(image: R.image.btn_imgdelete_n()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddImageItem() {
    return GestureDetector(
      onTap: () => _onImageButtonPressed(),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: R.color.background_color(),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          // fit: BoxFit.fill,
        ),
        child: Center(
          child: Image(image: R.image.btn_camera_n()),
        ),
      ),
    );
  }

  void _onImageButtonPressed() async {
    try {
      final pickedFileList = await _picker.getMultiImage();
      setState(() {
        _imageFileList = pickedFileList ?? <PickedFile>[];
      });
    } catch (e) {
      setState(() {
        // _pickImageError = e;
      });
    }
  }

  Widget _buildSubmitBtn() {
    return TextButton(
      onPressed: () => _onSubmitPressed(),
      child: Container(
        height: 44,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 28, vertical: 40),
        decoration: BoxDecoration(
          color: R.color.feedback_submit_btn_bg(),
          borderRadius: BorderRadius.all(Radius.circular(22)),
          // fit: BoxFit.fill,
        ),
        child: Center(
          child: Text(
            S.of(context).add_feedback_submit,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmitPressed() {
    if (_feedbackTypeIndex == null) {
      _showSnakeBar(S.of(context).add_feedback_type_error);
      return;
    }
    if (textController.text.isEmpty) {
      _showSnakeBar(S.of(context).add_feedback_content_error);
      return;
    }
    Fimber.d('@@type ${_getFeedbackType(_feedbackTypeIndex!)}');
    Fimber.d('@@input ${textController.text}');
    Fimber.d('@@image $_imageFileList');
    var filePathList = <String>[];
    _imageFileList.forEach((element) => filePathList.add(element.path));
    _addFeedbackBloc.add(CreateEvent(
        textController.text, (_feedbackTypeIndex ?? 0) + 1, filePathList));
  }

  void _showFeedbackTypeBottomSheet() {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      expand: false,
      context: context,
      builder: (context) => FeedbackTypeBottomSheet(index: _feedbackTypeIndex),
    ).then((value) => setState(() {
          _feedbackTypeIndex = value;
        }));
  }

  String _getFeedbackType(int which) {
    var arr = [
      S.of(context).add_feedback_type_0,
      S.of(context).add_feedback_type_1,
      S.of(context).add_feedback_type_2,
      S.of(context).add_feedback_type_3,
      S.of(context).add_feedback_type_4,
      S.of(context).add_feedback_type_5
    ];
    return arr[which];
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
