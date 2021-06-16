import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StatefulImage extends StatefulWidget {
  final Image image;
  final Image pressedImage;
  final VoidCallback onPressed;

  StatefulImage({Key? key, required this.image, required this.pressedImage, required this.onPressed})
      : super(key: key);

  @override
  _StatefulImageState createState() => _StatefulImageState();
}

class _StatefulImageState extends State<StatefulImage> {
  bool _changeColor = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _changeColor = !_changeColor),
      onTapUp: (_) => setState(() => _changeColor = !_changeColor),
      onTapCancel: () => setState(() => _changeColor = !_changeColor),
      child:IconButton(
        icon: _changeColor ? Image(image:widget.pressedImage.image) : Image(image:widget.image.image),
        onPressed: widget.onPressed,
      ),
    );
  }
}
