import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectorWidgetButton extends StatefulWidget {
  final Widget widgetN;
  final Widget widgetP;
  final VoidCallback onPressed;

  SelectorWidgetButton({Key? key, required this.widgetN, required this.widgetP, required this.onPressed})
      : super(key: key);

  @override
  _SelectorWidgetButtonState createState() => _SelectorWidgetButtonState();
}

class _SelectorWidgetButtonState extends State<SelectorWidgetButton> {
  bool _isChange = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isChange = !_isChange),
      onTapUp: (_) => setState(() => _isChange = !_isChange),
      onTapCancel: () => setState(() => _isChange = !_isChange),
      child:TextButton(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory
        ),
        onPressed: widget.onPressed,
        child: _isChange ? widget.widgetP : widget.widgetN,
      ),
    );
  }
}
