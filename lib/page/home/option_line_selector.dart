import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/home/line_selector_bloc.dart';
import 'package:qfvpn/model/api/bean/node/node_list_resp.dart';
import 'package:qfvpn/model/pref.dart';
import 'package:qfvpn/utility/flag_res_map.dart';

import '../../r.dart';
import '../../s.dart';

class OptionLineSelector extends StatefulWidget {
  final Items? defaultValue;

  OptionLineSelector(this.defaultValue);

  @override
  State<StatefulWidget> createState() => _OptionLineSelectorState();
}

class _OptionLineSelectorState extends State<OptionLineSelector> {
  late LineSelectorBloc _optionLineBloc;
  late int _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.defaultValue?.nodeId ?? 0;
    _optionLineBloc = BlocProvider.of<LineSelectorBloc>(context);
    _optionLineBloc.add(LineSelectorFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LineSelectorBloc, LineSelectorState>(
      listener: (context, state) {
        if (state is LoadedState) {}
      },
      child: BlocBuilder<LineSelectorBloc, LineSelectorState>(
        builder: (context, state) {
          if (state is LoadedState) {
            return Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(22))),
              child: Column(
                children: [
                  /** title **/
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).home_option_title_line,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color:
                                    R.color.home_vpn_option_sheet_title_text()),
                          )
                        ]),
                  ),
                  /** list **/
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: 0),
                      itemBuilder: (BuildContext context, int index) {
                        return buildListItem(
                            context, state.result.items!.elementAt(index));
                      },
                      itemCount: state.result.items!.length,
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildListItem(context, Items item) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.only(top: 19, bottom: 19, left: 20, right: 8),
            splashFactory: NoSplash.splashFactory,
            backgroundColor: _selectedId == item.nodeId
                ? R.color.home_vpn_option_sheet_item_selected_bg()
                : R.color.home_vpn_option_sheet_item_unselected_bg(),
            side: BorderSide(
                color: _selectedId == item.nodeId
                    ? R.color.home_vpn_option_sheet_item_selected_bg_border()
                    : Colors.transparent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
        onPressed: () {
          setState(() {
            _selectedId = item.nodeId ?? -1;
          });
          Pref().setupOptionLine(item);
          Navigator.pop(context, item);
        },
        child: Row(
          children: [
            Image(image: FlagResMap().get(item.country ?? '')),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                item.name ?? '',
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 14,
                    color: R.color.home_vpn_option_sheet_item_line_title()),
              ),
            )),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: IndexedStack(
                index: item.loadLevel! - 1,
                children: [
                  Image(image: R.image.ico_signal_1()),
                  Image(image: R.image.ico_signal_2()),
                  Image(image: R.image.ico_signal_3()),
                ],
              ),
            ),
            Image(
                image: _selectedId == item.nodeId
                    ? R.image.btn_radio_p()
                    : R.image.btn_radio_n())
          ],
        ));
  }
}
