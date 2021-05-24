import 'package:flutter/material.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/utilities/assets.dart';

class MobileDashboardTextField extends StatefulWidget {
  final Color color;
  final TextEditingController ctrl;
  final String label;
  final TextInputType inputType;
  final bool isPassword;

  const MobileDashboardTextField(
      {Key key,
      this.color,
      this.ctrl,
      this.label,
      this.inputType,
      this.isPassword})
      : super(key: key);

  @override
  _customButtonState createState() => _customButtonState();
}

class _customButtonState extends State<MobileDashboardTextField> {
  bool _showPassword;

  @override
  void initState() {
    _showPassword = widget.isPassword ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdvColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.label, style: TextStyle(color: Colors.white)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          color: widget.color,
          child: TextField(
              controller: widget.ctrl,
              keyboardType: widget.inputType,
              obscureText: _showPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffix: widget.isPassword ?? false
                      ? InkWell(
                          child: Image.asset(Assets.showPassword,
                              height: 24, width: 24),
                          onTap: () =>
                              setState(() => _showPassword = !_showPassword),
                        )
                      : null)),
        )
      ],
    );
  }
}
