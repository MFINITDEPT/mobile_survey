import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/component/adv_row.dart';
import 'package:mobilesurvey/logic/assets.dart';
import 'package:mobilesurvey/model/photo_result.dart';
import 'package:mobilesurvey/utilities/date_utils.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobilesurvey/utilities/ui_utils.dart';

class AssetsUI extends StatefulWidget {
  @override
  _AssetsUIState createState() => _AssetsUIState();
}

class _AssetsUIState extends NewState<AssetsUI> {
  final AssetsBase _logic = AssetsBase();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(body: Observer(builder: (_) {
      return ListView.builder(
          itemCount: _logic.results.length,
          itemBuilder: (context, index) =>
              _buildPhotoBox(_logic.results[index], context));
    }));
  }

  Widget _buildPhotoBox(PhotoResult photo, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AdvColumn(
        divider: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ColumnDivider(1.0, color: Palette.gold.withOpacity(0.5))),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(photo.form.kelengkapan,
                style: TextStyle(
                    color: Palette.gold, fontWeight: FontWeight.w600)),
          ),
          _buildPhotoBoxContainer(photo, context)
        ],
      ),
    );
  }

  Widget _buildPhotoBoxContainer(PhotoResult photo, BuildContext context) {
    var width = MediaQuery.of(context).size.width / 3;
    return AdvColumn(
      children: [
        AdvRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: AdvRow(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: width),
                      child: Text(
                        translation.getText('filename'),
                        style: TextStyle(
                            color: Palette.navy,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600),
                      )),
                  ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: width),
                      child: Text(translation.getText('date'),
                          style: TextStyle(
                              color: Palette.navy,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600))),
                  ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: width),
                      child: Text(translation.getText('time'),
                          style: TextStyle(
                              color: Palette.navy,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600))),
                ],
              ),
            ),
            Flexible(child: Container())
          ],
        ),
        Container(
          decoration: BoxDecoration(
              color: Palette.grey,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          child: AdvColumn(
              children: List.generate(photo.form.count,
                  (index) => _buildItemPhoto(width, photo, index, context))),
        )
      ],
    );
  }

  Widget _buildItemPhoto(
      double width, PhotoResult photo, int index, BuildContext context) {
    return AdvRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: AdvRow(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width),
                  child: UIUtils.documentIcon(
                      _logic.document(photo.form, index),
                      isDocument: photo.form.type.toLowerCase() == "dokumen")),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width),
                  child: Text(
                      _logic.document(photo.form, index) != null
                          ? DateUtils.convertDateTimeToString(
                              _logic.document(photo.form, index).dateTime)
                          : translation.getText('date'),
                      style: TextStyle(
                        color: Palette.black.withOpacity(0.6),
                        fontSize: 12.0,
                      ))),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width),
                  child: Text(
                      _logic.document(photo.form, index) != null
                          ? DateUtils.convertDateTimeToTimeString(
                              _logic.document(photo.form, index).dateTime)
                          : translation.getText('time'),
                      style: TextStyle(
                          color: Palette.black.withOpacity(0.6),
                          fontSize: 12.0))),
            ],
          ),
        ),
        Flexible(
          child: Material(
            color: Palette.grey,
            child: InkWell(
              onTap: () =>
                  _logic.browseFile(photo.form, index, setState, context),
              splashColor: Palette.blue,
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: UIUtils.assetsIcon(
                      isDocument: photo.form.type.toLowerCase() == "dokumen")),
            ),
          ),
        )
      ],
    );
  }
}
