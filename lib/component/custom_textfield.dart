import 'package:flutter/material.dart';
import '../utilities/palette.dart';

class CustomTextField extends StatefulWidget {
  final double padding;
  final String title;
  final TextEditingController controller;
  final bool enabled;
  final bool obsecureText;

  CustomTextField(
      {Key key,
      this.padding,
      @required this.title,
      @required this.controller,
      this.enabled = true,
      this.obsecureText = false})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding ?? 12.0),
      child: TextField(
          obscureText: widget.obsecureText,
          enabled: widget.enabled,
          controller: widget.controller,
          style:
              TextStyle(color: Palette.black.withOpacity(0.9), fontSize: 12.0),
          decoration: InputDecoration(
              hintText: widget.title ?? "",
              contentPadding: EdgeInsets.all(widget.padding ?? 12.0),
              hintStyle: TextStyle(
                  color: Palette.black.withOpacity(0.9), fontSize: 12.0),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Palette.gold.withOpacity(0.3))),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Palette.gold.withOpacity(0.3))),
              disabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Palette.gold.withOpacity(0.3))))),
    );
  }
}
