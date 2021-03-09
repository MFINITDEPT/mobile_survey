import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/logic/document.dart';
import 'package:mobilesurvey/model/photo_result.dart';
import 'package:mobilesurvey/utilities/mime_utils.dart';
import 'package:mobilesurvey/utilities/palette.dart';

class DocumentUI extends StatefulWidget {
  @override
  _DocumentUIState createState() => _DocumentUIState();
}

class _DocumentUIState extends NewState<DocumentUI> {
  DocumentBase _logic;

  @override
  void initState() {
    _logic = DocumentBase(this);
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(photo.form.kelengkapan),
          ),
          Center(
            child: Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: List.generate(
                    photo.form.count, (index) => _buildBox(photo, index))),
          ),
        ],
      ),
    );
  }

  Widget _buildBox(PhotoResult photo, int index) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
              onTap: () => _logic.image(photo.form, index) != null
                  ? _logic.openFile(_logic.image(photo.form, index).path)
                  : _logic.browseFile(photo.form, index),
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                  child: _logic.image(photo.form, index) != null
                      ? MimeUtils.isImage(_logic.image(photo.form, index).path)
                          ? Image.file(_logic.image(photo.form, index),
                              fit: BoxFit.cover)
                          : Icon(Icons.description)
                      : Icon(Icons.add),
                  color: Palette.black26,
                  height: 100,
                  width: 100)),
        ),
        if (_logic.image(photo.form, index) != null)
          Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: MaterialButton(
                  onPressed: () => _logic.removePhoto(photo, index),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Icon(Icons.close, size: 20.0),
                  shape: CircleBorder(),
                ),
              ),
              top: -15.0,
              right: -30.0)
      ],
    );
  }
}
