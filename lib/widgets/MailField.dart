import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../r.dart';
import '../s.dart';

class MailField extends StatefulWidget {
  const MailField({this.prefixIcon, this.controller, this.validator});

  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  State<StatefulWidget> createState() => _MailFieldState();
}

class _MailFieldState extends State<MailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        maxLength: 20,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          counterText: '',
          prefixIcon: widget.prefixIcon,
          prefixIconConstraints: BoxConstraints(minWidth: 24, maxHeight: 24),
          hintStyle: TextStyle(color: R.color.login_hint_color(), fontSize: 14),
          hintText: S.of(context).login_email_hint,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: R.color.text_field_border_color()),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: R.color.text_field_border_color()),
          ),
        ),
        autovalidateMode: AutovalidateMode.always,
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        validator: widget.validator);
  }
}
