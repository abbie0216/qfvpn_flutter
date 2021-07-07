import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../r.dart';
import '../../s.dart';

class FeedbackTypeBottomSheet extends StatefulWidget {
  final int? index;
  FeedbackTypeBottomSheet({this.index});

  @override
  State<StatefulWidget> createState() => _FeedbackTypeBottomSheetState();
}

class _FeedbackTypeBottomSheetState extends State<FeedbackTypeBottomSheet> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    _selectedIndex = widget.index;
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
              Center(
                child: Text(
                  S.of(context).add_feedback_type,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: R.color.home_vpn_option_sheet_title_text()),
                ),
              ),
              SizedBox(height: 10),
              _buildOptionItem(0),
              SizedBox(height: 10),
              _buildOptionItem(1),
              SizedBox(height: 10),
              _buildOptionItem(2),
              SizedBox(height: 10),
              _buildOptionItem(3),
              SizedBox(height: 10),
              _buildOptionItem(4),
              SizedBox(height: 10),
              _buildOptionItem(5),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOptionItem(int which) {
    var text = _getOptionTitle(which);
    var isSelected = _selectedIndex == which;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: isSelected
              ? R.color.feedback_option_sheet_item_selected_bg()
              : R.color.feedback_option_sheet_item_unselected_bg(),
          side: BorderSide(
              color: isSelected
                  ? R.color.feedback_option_sheet_item_selected_bg_border()
                  : R.color.feedback_option_sheet_item_unselected_bg_border()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
      onPressed: () {
        setState(() {
          _selectedIndex = which;
        });
        Navigator.pop(context, which);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: isSelected
                      ? R.color.text_blue_color()
                      : R.color.text_color_alpha40(),
                  fontSize: isSelected ? 18 : 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
            ),
            Image(
                image: _selectedIndex == which
                    ? R.image.btn_radio_p()
                    : R.image.btn_radio_n())
          ],
        ),
      ),
    );
  }

  String _getOptionTitle(int which) {
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
}
