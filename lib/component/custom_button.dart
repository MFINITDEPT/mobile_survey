import 'package:flutter/material.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobilesurvey/utilities/palette.dart';

/// a component for Custom Button
// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  ///title for custom button
  String title;
  /// onPress void function for custom button
  void Function() onPress;
  /// button color for custom button
  Color buttonColor;
  /// text color for custom button
  Color textColor;
  ///button width for custom button
  double buttonWidth;

  /// constructor for CustomButton
  CustomButton(this.title,
      {Key key,
      this.onPress,
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
      onPressed: widget.onPress,
      textColor: widget.textColor ?? Palette.white,
      color: widget.buttonColor ?? Palette.navy,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: widget.textColor ?? Palette.navy),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
