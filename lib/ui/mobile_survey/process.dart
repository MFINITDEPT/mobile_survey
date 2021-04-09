import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/component/custom_button.dart';
import 'package:mobilesurvey/utilities/palette.dart';

class ProcessUI extends StatefulWidget {
  @override
  _ProcessUIState createState() => _ProcessUIState();
}

class _ProcessUIState extends State<ProcessUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildItem("Quisioner", "Done"),
            _buildItem("Assets", "Process"),
            _buildItem("Document", "Done"),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: CustomButton(
                "submit",
                onPress: () => print("hello"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String title, String status) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: TextStyle(color: Palette.gold, fontWeight: FontWeight.w500),
      ),
      Chip(label: Text(status))
    ]);
  }
}
