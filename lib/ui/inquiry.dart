import 'package:flutter/material.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/logic/inquiry.dart';

class InquiryUI extends StatefulWidget {
  @override
  _InquiryUIState createState() => _InquiryUIState();
}

class _InquiryUIState extends NewState<InquiryUI> {
  InquiryBase _logic;

  @override
  void initState() {
    _logic = InquiryBase(this);
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inquiry")),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) => _item(index),
          separatorBuilder: (BuildContext context, int index) =>
              Divider(color: Colors.red),
          itemCount: 10),
    );
  }

  Widget _item(int index) {
    return Card(
      child: InkWell(
        onTap: () => _logic.navigateToSurvey(index),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [Text("nopol $index"), Text("Nama $index")],
          ),
        ),
      ),
    );
  }
}
