import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/component/adv_row.dart';
import 'package:mobilesurvey/logic/assets.dart';
import 'package:mobilesurvey/model/photo_result.dart';
import 'package:mobilesurvey/utilities/mime_utils.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/ui_utils.dart';

class AssetsUI extends StatefulWidget {
  @override
  _AssetsUIState createState() => _AssetsUIState();
}

class _AssetsUIState extends NewState<AssetsUI> {
  AssetsBase _logic;

  @override
  void initState() {
    _logic = AssetsBase(this);
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(body: Observer(builder: (_) {
      return ListView.builder(
          itemCount: _logic.results.length,
          itemBuilder: (context, index) =>
              _buildPhotoBox(_logic.results[index]));
    }));
  }

  Widget _buildPhotoBox(PhotoResult photo) {
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
          _buildPhotoBoxContainer(photo)
        ],
      ),
    );
  }

  Widget _buildPhotoBoxContainer(PhotoResult photo) {
    var width = MediaQuery.of(context).size.width / 3;
    return AdvColumn(
      children: [
        AdvRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: AdvRow(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: width),
                      child: Text(
                        "File Name",
                        style: TextStyle(
                            color: Palette.navy,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600),
                      )),
                  ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: width),
                      child: Text("Date",
                          style: TextStyle(
                              color: Palette.navy,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600))),
                  ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: width),
                      child: Text("Time",
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
                  (index) => _buildItemPhoto(width, photo, index))),
        )
      ],
    );
  }

  Widget _buildItemPhoto(double width, PhotoResult photo, int index) {
    return AdvRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: AdvRow(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: width),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _logic.image(photo.form, index) != null
                        ? Image.file(_logic.image(photo.form, index),
                            height: 40, width: 40, fit: BoxFit.cover)
                        : Container(
                            height: 40, width: 40, color: Palette.navy)),
              ),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width),
                  child: Text("12/03/21",
                      style: TextStyle(
                        color: Palette.black.withOpacity(0.6),
                        fontSize: 12.0,
                      ))),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width),
                  child: Text("18.35",
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
              onTap: () => _logic.browseFile(photo.form, index),
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
