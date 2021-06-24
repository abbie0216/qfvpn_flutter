import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../r.dart';
import '../../s.dart';

class OptionLineBottomSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OptionLineBottomSheetState();
}

class _OptionLineBottomSheetState extends State<OptionLineBottomSheet> {
  int _selectedId = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
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
                        color: R.color.home_vpn_option_sheet_title_text()),
                  )
                ]),
          ),
          /** list **/
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 0),
              itemBuilder: buildListItem,
              itemCount: 30,
            ),
          )
        ],
      ),
    );
  }

  Widget buildListItem(context, int index) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.only(top: 19, bottom: 19, left: 20, right: 8),
            splashFactory: NoSplash.splashFactory,
            backgroundColor: _selectedId == index
                ? R.color.home_vpn_option_sheet_item_selected_bg()
                : R.color.home_vpn_option_sheet_item_unselected_bg(),
            side: BorderSide(
                color: _selectedId == index
                    ? R.color.home_vpn_option_sheet_item_selected_bg_border()
                    : Colors.transparent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
        onPressed: () {
          setState(() {
            _selectedId = index;
          });
          Navigator.pop(context);
        },
        child: Row(
          children: [
            Image(image: R.image.flag_japan()),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '日本-$index',
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 14,
                    color: R.color.home_vpn_option_sheet_item_line_title()),
              ),
            )),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Image(image: R.image.ico_signal_3()),
            ),
            Image(
                image: _selectedId == index
                    ? R.image.btn_radio_p()
                    : R.image.btn_radio_n())
          ],
        ));
  }
}
