import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../r.dart';
import '../s.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({this.prefixIcon, this.suffixIcon, this.hintColor, this.textColor
    , this.obscureText = false, this.controller, this.validator});

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Color? hintColor;
  final Color? textColor;

  @override
  State<StatefulWidget> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLength: 20,
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        counterText: '',
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints:
        BoxConstraints(minWidth: 24, maxHeight: 24),
        suffixIcon: widget.suffixIcon,
        hintStyle: TextStyle(
            color: widget.hintColor, fontSize: 14),
        hintText: S
            .of(context)
            .login_pw_hint,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: R.color.text_field_border_color()),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: R.color.text_field_border_color()),
        ),
      ),
      obscureText: widget.obscureText,
      autovalidateMode: AutovalidateMode.always,
      autocorrect: false,
      style: TextStyle(color: widget.textColor),
      validator: widget.validator
    );
  }
}