import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qfvpn/model/pref.dart';
import 'package:qfvpn/r.dart';
import 'package:qfvpn/s.dart';

class OptionModeSelector extends StatefulWidget {
  final int? defaultValue;

  OptionModeSelector(this.defaultValue);

  @override
  State<StatefulWidget> createState() => _OptionModeSelectorState();
}

class _OptionModeSelectorState extends State<OptionModeSelector> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultValue??0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
          child: Column(
            children: [
              /** title **/
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).home_option_title_mode,
                        textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: R.color.home_vpn_option_sheet_title_text()
                    ),)
                  ]),
              /** item 1 **/
              Padding(padding: EdgeInsets.only(top: 16), child: buildOptionItem(0)),
              /** item 2 **/
              Padding(padding: EdgeInsets.only(top:8), child: buildOptionItem(1)),
            ],
          ),
        )
      ],
    );
  }

  Widget buildOptionItem(int which) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: _selectedIndex == which
              ? R.color.home_vpn_option_sheet_item_selected_bg()
              : R.color.home_vpn_option_sheet_item_unselected_bg(),
          side: BorderSide(
              color: _selectedIndex == which
                  ? R.color.home_vpn_option_sheet_item_selected_bg_border()
                  : R.color.home_vpn_option_sheet_item_unselected_bg_border()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
      onPressed: () {
        setState(() {
          _selectedIndex = which;
        });
        Pref().setupOptionMode(which);
        Navigator.pop(context, which);
      },
      child: Container(
        padding: EdgeInsets.only(top: 20,bottom: 20),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    which == 0
                        ? S.of(context).home_option_mode_list_item_title_1
                        : S.of(context).home_option_mode_list_item_title_2,
                    style: TextStyle(
                        color: R.color.home_vpn_option_sheet_item_mode_title(),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Image(
                      image: _selectedIndex == which
                          ? R.image.btn_radio_p()
                          : R.image.btn_radio_n())
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 52,top: 4),
                child: Text(
                  which == 0
                      ? S.of(context).home_option_mode_list_item_desc_1
                      : S.of(context).home_option_mode_list_item_desc_2,
                  style: TextStyle(
                      color: R.color.home_vpn_option_sheet_item_mode_desc(),
                      fontSize: 14),
                ),
              )
            ],
          )),
    );
  }
}
