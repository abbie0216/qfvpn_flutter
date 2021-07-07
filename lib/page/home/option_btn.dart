import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qfvpn/bloc/home/option_btn_bloc.dart';
import 'package:qfvpn/model/api/bean/node/node_list_result.dart';
import 'package:qfvpn/utility/flag_res_map.dart';
import 'package:qfvpn/widget/ink_wrapper.dart';

import '../../r.dart';
import '../../s.dart';
import 'option_line_selector.dart';
import 'option_mode_selector.dart';

class OptionBtn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OptionBtnState();
}

class _OptionBtnState extends State<OptionBtn> {
  late OptionBtnBloc _optionBtnBloc;
  int? _mode;
  Items? _line;

  @override
  void initState() {
    super.initState();
    _optionBtnBloc = BlocProvider.of<OptionBtnBloc>(context);
    _optionBtnBloc.add(OptionBtnFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OptionBtnBloc, OptionBtnState>(
      listener: (context, state) {
        if (state is LoadedState) {
          setState(() {
            _mode = state.result.optionMode;
            _line = state.result.optionLine;
          });
        }
      },
      child: BlocBuilder<OptionBtnBloc, OptionBtnState>(
        builder: (context, state) {
          return Card(
            elevation: 3,
            shadowColor: R.color.home_card_shadow(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              children: [
                _buildOptionModeBtn(),
                Container(
                    color: R.color.home_vpn_option_divider(),
                    height: 1,
                    width: double.infinity),
                _buildOptionLineBtn(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOptionModeBtn() {
    return InkWrapper(
      onTap: () {
        _showOptionModeBottomSheet();
      },
      radius: BorderRadius.only(
          topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 22, bottom: 17, right: 11),
        child: Row(children: [
          Text(
            S.of(context).home_option_title_mode,
            style: TextStyle(
                fontSize: 14, color: R.color.home_vpn_option_title_text()),
          ),
          Expanded(
              child: Text(_getModeText(),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 14,
                      color: R.color.home_vpn_option_value_text()))),
          Padding(
              padding: EdgeInsets.only(left: 4),
              child: Image(image: R.image.btn_next_n()))
        ]),
      ),
    );
  }

  Widget _buildOptionLineBtn() {
    return InkWrapper(
      onTap: () {
        _showOptionLineBottomSheet();
      },
      radius: BorderRadius.only(
          bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 17, bottom: 22, right: 11),
        child: Row(children: [
          Text(
            S.of(context).home_option_title_line,
            style: TextStyle(
                fontSize: 14, color: R.color.home_vpn_option_title_text()),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 4),
            child: Image(image: _getLineImage()),
          ),
          Text(_getLineText(),
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 14, color: R.color.home_vpn_option_value_text())),
          Padding(
              padding: EdgeInsets.only(left: 4),
              child: Image(image: R.image.btn_next_n()))
        ]),
      ),
    );
  }

  String _getModeText() {
    switch (_mode) {
      case 0:
        return S.of(context).home_option_mode_list_item_title_1;
      case 1:
        return S.of(context).home_option_mode_list_item_title_2;
      default:
        return '';
    }
  }

  String _getLineText() {
    return _line?.name ?? '';
  }

  AssetImage _getLineImage() {
    return FlagResMap().get(_line?.country ?? '');
  }

  void _showOptionModeBottomSheet() {
    showMaterialModalBottomSheet(
        backgroundColor: Colors.transparent,
        expand: false,
        context: context,
        builder: (context) => OptionModeSelector(_mode)).then((result) {
      if (result != _mode) {
        Fimber.d('mode selected: $result');
        setState(() {
          _mode = result;
        });
      }
    });
  }

  void _showOptionLineBottomSheet() {
    showMaterialModalBottomSheet(
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => OptionLineSelector(_line)).then((result) {
      if (result is Items && result.nodeId != _line?.nodeId) {
        setState(() {
          _line = result;
        });
      }
    });
  }
}
