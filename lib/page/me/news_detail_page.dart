import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/me/news/news_detail_bloc.dart';
import '../../r.dart';
import '../../s.dart';

class NewsDetailPage extends StatefulWidget {
  NewsDetailPage({Key? key}) : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late NewsDetailBloc _newsDetailBloc;

  @override
  void initState() {
    super.initState();
    _newsDetailBloc = BlocProvider.of<NewsDetailBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewsDetailBloc, NewsDetailState>(
      listener: (context, state) {},
      child: BlocBuilder<NewsDetailBloc, NewsDetailState>(
          builder: (context, state) {
        return Scaffold(
            backgroundColor: R.color.background_color(),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(S.of(context).news_detail,
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
            body: _buildContentView());
      }),
    );
  }

  Widget _buildContentView() {
    return BlocListener<NewsDetailBloc, NewsDetailState>(
        listener: (context, state) {},
        child: BlocBuilder<NewsDetailBloc, NewsDetailState>(
            builder: (context, state) {
          return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('标题文字标题文字标题文字标题文字标题文字字',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          color: R.color.text_blue_color(),
                          fontWeight: FontWeight.bold)),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: Text('2020-10-10',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withAlpha(128)))),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Text(
                              '内容内容\n\n\n内容内容内容内容内容内容内容内容内容内容内容内容内容内容内内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内\n\n\n内容内容内容内容内容内容内容内容内容内容内容内容内容内容内内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内\n内容内容内容内容内容内容内容内容内容内容内容内容内容内容内内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内',
                              style: TextStyle(
                                  color: R.color.text_color_alpha80()))))
                ],
              ));
        }));
  }
}
