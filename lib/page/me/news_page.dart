import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/me/news/news_bloc.dart';
import 'package:qfvpn/page/me/news_detail_page.dart';
import '../../r.dart';
import '../../s.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late NewsBloc _newsBloc;

  List<bool> isSelected = [true, false];

  @override
  void initState() {
    super.initState();
    _newsBloc = BlocProvider.of<NewsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewsBloc, NewsState>(
      listener: (context, state) {},
      child: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
        return Scaffold(
            backgroundColor: R.color.background_color(),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(S.of(context).news_title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: R.color.text_blue_color()),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
              backgroundColor: R.color.background_color(),
              centerTitle: true,
            ),
            body: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: LayoutBuilder(
                          builder: (context, constraints) => ToggleButtons(
                                constraints: BoxConstraints.expand(
                                    width: constraints.maxWidth / 2 - 16,
                                    height: 32),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderColor: R.color.btn_blue_color(),
                                selectedBorderColor: R.color.btn_blue_color(),
                                selectedColor: Colors.white,
                                fillColor: R.color.btn_blue_color(),
                                onPressed: (int index) {
                                  setState(() {
                                    for (var i = 0;
                                        i < isSelected.length;
                                        i++) {
                                      isSelected[i] = i == index;
                                    }
                                  });
                                },
                                isSelected: isSelected,
                                children: [
                                  Text(S.of(context).news_system),
                                  Text(S.of(context).news_mime)
                                ],
                              ))),
                  Expanded(child: _buildContentView())
                ]));
      }),
    );
  }

  Widget _buildContentView() {
    return BlocListener<NewsBloc, NewsState>(
        listener: (context, state) {},
        child: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
          return ListView.separated(
            itemCount: 12, //for test
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            itemBuilder: (BuildContext context, int index) {
              if (index == 0 || index == 3) {
                //test
                return _buildDateTitle(index);
              } else {
                return _buildItem(index);
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 10,
                color: Colors.transparent,
              );
            },
          );
        }));
  }

  Widget _buildDateTitle(int index) {
    return Center(
      child: Text('今天',
          style: TextStyle(color: Colors.black.withAlpha(128), fontSize: 12)),
    );
  }

  Widget _buildItem(int index) {
    return BlocListener<NewsBloc, NewsState>(
        listener: (context, state) {},
        child: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
          return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, (NewsDetailPage).toString());
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  height: 115,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    // fit: BoxFit.fill,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7.5),
                                    child: Icon(Icons.circle,
                                        size: 5, color: Colors.red)),
                                Expanded(
                                    child: Text('标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold))),
                                Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Image(image: R.image.btn_next_n()))
                              ])),
                      Expanded(
                          flex: 2,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('文字内容文字内容文字内容文字字内容文文字内容文字内容文字内容文字字内容文文字内容文字内容文字内容文字字内容文',
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: R.color.text_color_alpha80(),
                                          fontSize: 14))))),
                    ],
                  )));
        }));
  }
}
