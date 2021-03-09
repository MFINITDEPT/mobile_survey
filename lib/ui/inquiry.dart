import 'package:flutter/material.dart';
import 'package:mobilesurvey/ui/home_container.dart';
import 'package:mobilesurvey/utilities/constant.dart';

class InquiryUI extends StatefulWidget {
  @override
  _InquiryUIState createState() => _InquiryUIState();
}

class _InquiryUIState extends State<InquiryUI> {
  @override
  Widget build(BuildContext context) {
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
        onTap: () {
          kLastSavedClient = index.toString();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      HomeContainerUI(id: index.toString())));
        },
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
