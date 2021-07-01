import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/feedback/feedback_bloc.dart';
import 'package:qfvpn/bloc/feedback/feedback_state.dart';

import '../../r.dart';
import '../../s.dart';

class FeedbackDetailPage extends StatefulWidget {
  FeedbackDetailPage({Key? key}) : super(key: key);

  @override
  _FeedbackDetailState createState() => _FeedbackDetailState();
}

class _FeedbackDetailState extends State<FeedbackDetailPage> {
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
            title: Text(S.of(context).feedback_detail_title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: R.color.text_blue_color()),
              onPressed: () => Navigator.of(context).pop(),
            ),
            elevation: 0,
            backgroundColor: R.color.background_color(),
            centerTitle: true,
          ),
        );
      }),
    );
  }
}
