import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qfvpn/bloc/feedback/feedback_bloc.dart';
import 'package:qfvpn/bloc/feedback/feedback_state.dart';
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
              S.of(context).add_feedback_select,
              style:
                  TextStyle(color: R.color.text_color_alpha30(), fontSize: 14),
            ),
            Spacer(),
            Image(image: R.image.btn_dropdown_n()),
          ],
        ),
      ),
    );
  }

  int letterCount = 0;

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
    var size = _imageFileList?.length ?? 0;
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
            child: Image.file(File(_imageFileList![index].path),
                fit: BoxFit.cover, width: 80, height: 80),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Image(image: R.image.btn_imgdelete_n()),
          ),
        ],
      ),
    );
  }

  final _picker = ImagePicker();
  late final PickedFile? pickedFile;

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

  List<PickedFile>? _imageFileList;

  void _onImageButtonPressed() async {
    try {
      final pickedFileList = await _picker.getMultiImage();
      setState(() {
        _imageFileList = pickedFileList;
      });
    } catch (e) {
      setState(() {
        // _pickImageError = e;
      });
    }
  }

  Widget _buildSubmitBtn() {
    return TextButton(
      onPressed: null,
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

  void _showFeedbackTypeBottomSheet() {
    showMaterialModalBottomSheet(
        backgroundColor: Colors.transparent,
        expand: false,
        context: context,
        builder: (context) => FeedbackTypeBottomSheet());
  }
}
