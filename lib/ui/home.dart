import 'package:flutter/material.dart';

import '../boilerplate/new_state.dart';
import '../component/adv_column.dart';
import '../logic/home.dart';
import '../utilities/assets.dart';
import '../utilities/palette.dart';
import '../utilities/translation.dart';

// ignore: public_member_api_docs
class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends NewState<HomeUI> {
  final HomeBase _logic = HomeBase();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: AdvColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
            child: Text(
              "${translation.getText('welcome')}, TEST",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Palette.navy),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            child: Text(
              translation.getText('task'),
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Palette.navy),
            ),
          ),
          Flexible(
              child: ListView.separated(
                  itemBuilder: (context, index) => _buildItem(index, context),
                  separatorBuilder: (context, index) => _buildSeparator(),
                  itemCount: 10))
        ],
      ),
    );
  }

  Widget _buildItem(int index, BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
      onTap: () => _logic.onSelectedItem(index.toString(), context),
      title: Text(
        "Nanang Hermawan",
        style: TextStyle(
            color: Palette.gold, fontSize: 12.0, fontWeight: FontWeight.w500),
      ),
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
