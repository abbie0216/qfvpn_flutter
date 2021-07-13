import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:qfvpn/bloc/me/points/points_detail_bloc.dart';
import 'package:qfvpn/model/api/bean/points/PointsDetailResp.dart';

import '../../constants.dart';
import '../../r.dart';
import '../../s.dart';

class PointsDetailPage extends StatefulWidget {
  PointsDetailPage({Key? key}) : super(key: key);

  @override
  _PointsDetailPageState createState() => _PointsDetailPageState();
}

class _PointsDetailPageState extends State<PointsDetailPage> {
  late PointsDetailBloc _pointsDetailBloc;

  var _pageKey;
  final PagingController<int, PointDetail> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pointsDetailBloc = BlocProvider.of<PointsDetailBloc>(context);
    _pagingController.addPageRequestListener((pageKey) {
      _pageKey = pageKey;
      _pointsDetailBloc.add(FetchListEvent(pageKey));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PointsDetailBloc, PointsDetailState>(
      listener: (context, state) {
        if (state is ListLoadedState) {
          Fimber.d('ListLoadedState');
          var newItems = state.data.items;
          if (newItems != null) {
            final isLastPage = newItems.length < PAGE_SIZE;
            if (isLastPage) {
              Fimber.d('ListLoadedState isLastPage');
              _pagingController.appendLastPage(newItems);
            } else {
              final nextPageKey = ++_pageKey;
              Fimber.d('ListLoadedState $nextPageKey');
              _pagingController.appendPage(newItems, nextPageKey);
            }
          } else {
            Fimber.d('ListLoadedState null');
          }
        }
      },
      child: BlocBuilder<PointsDetailBloc, PointsDetailState>(
          builder: (context, state) {
        return Scaffold(
            backgroundColor: R.color.background_color(),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(S.of(context).points_detail_title,
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
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => _pagingController.refresh(),
      ),
      child: PagedListView<int, PointDetail>.separated(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<PointDetail>(
          itemBuilder: (context, item, index) => _buildItem(item, index),
          // noItemsFoundIndicatorBuilder: (_) => _buildNoItemsFoundIndicator(),
        ),
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 10,
            color: Colors.transparent,
          );
        },
      ),
    );
  }

  Widget _buildItem(PointDetail item, int index) {
    return Container(
        height: 64,
        padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('yyyy/MM/dd hh:mm')
                          .format(DateTime.parse(item.changeAt)),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: R.color.text_gray_color(), fontSize: 12),
                    ),
                    Text(
                      item.remark,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: R.color.text_color_alpha80()),
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: Text(
                  '${item.inOrOut == "in" ? "+" : "-"}${item.point}',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: R.color.text_blue_color()),
                )),
          ],
        ));
  }

}
