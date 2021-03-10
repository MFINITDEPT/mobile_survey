import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobilesurvey/model/photo_result.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/ui/home_container.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/enum.dart';

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

          List<PhotoResult> _resultPhoto = List<PhotoResult>();
          List<PhotoResult> _resultDoc = List<PhotoResult>();

          MasterRepositories.photoForm.forEach((element) {
            PhotoResult _item = PhotoResult();
            _item.form =
                MasterRepositories.photoForm.firstWhere((item) => element == item);
            _item.result = List<File>(element.count);

            _resultPhoto.add(_item);
          });

          MasterRepositories.docPhoto.forEach((element) {
            PhotoResult _item = PhotoResult();
            _item.form =
                MasterRepositories.docPhoto.firstWhere((item) => element == item);
            _item.result = List<File>(element.count);

            _resultDoc.add(_item);
          });

          MasterRepositories.savePhotoFormResult(_resultPhoto, master.pic);
          MasterRepositories.savePhotoFormResult(_resultDoc, master.doc);

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
