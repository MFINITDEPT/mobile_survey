import 'package:flutter/material.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/logic/history.dart';
import 'package:mobilesurvey/utilities/assets.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/translation.dart';

// ignore: public_member_api_docs
class HistoryUI extends StatefulWidget {
  @override
  _HistoryUIState createState() => _HistoryUIState();
}

class _HistoryUIState extends State<HistoryUI> {
  final HistoryBase _logic = HistoryBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdvColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              translation.getText('completed_task'),
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Palette.navy),
            ),
          ),
          Flexible(
              child: ListView.separated(
                  itemBuilder: (context, index) => _buildItem(index),
                  separatorBuilder: (context, index) => _buildSeparator(),
                  itemCount: 10))
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
      onTap: _logic.onSelectedItem,
      title: Text(
        "Nanang Hermawan",
        style: TextStyle(
            color: Palette.gold, fontSize: 12.0, fontWeight: FontWeight.w500),
      ),
      isThreeLine: true,
      subtitle: AdvColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        divider: ColumnDivider(4.0),
        children: [
          Text("B 1234 CA",
              style: TextStyle(
                  color: Palette.navy,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500)),
          Text(DateTime.now().toString(),
              style: TextStyle(
                  color: Palette.grey,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500))
        ],
      ),
      trailing: InkWell(
        onTap: _logic.onMapPress,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(Assets.location, height: 24, width: 24),
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: ColumnDivider(2.0, color: Palette.gold),
    );
  }
}
