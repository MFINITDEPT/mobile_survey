import 'package:flutter/material.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobilesurvey/utilities/palette.dart';

class CustomButton extends StatefulWidget {
  String title;
  void Function() onpress;
  Color buttonColor;
  Color textColor;
  double buttonWidth;

  CustomButton(this.title,
      {Key key,
      this.onpress,
      this.textColor,
      this.buttonColor,
      this.buttonWidth})
      : assert(title != null && title != "",
            "title can't be null and can't be empty string"),
        super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        width: widget.buttonWidth ?? double.infinity,
        alignment: Alignment.center,
        child: Text(translation.getText(widget.title)),
      ),
      onPressed: widget.onpress,
      textColor: widget.textColor ?? Palette.white,
      color: widget.buttonColor ?? Palette.prime,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: widget.textColor ?? Palette.prime),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
