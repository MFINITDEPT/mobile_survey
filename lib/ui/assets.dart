import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/logic/assets.dart';
import 'package:mobilesurvey/utilities/palette.dart';

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
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) => _buildPhotoBox(3),
        itemCount: 5);
  }

  Widget _buildPhotoBox(int items) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AdvColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text("Foto Assets"),
          ),
          Center(
            child: Wrap(spacing: 16.0, runSpacing: 16.0, children: [
              _buildBox(),
              _buildBox(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildBox() {
    return Stack(
      overflow: Overflow.visible,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
              onTap: _logic.takePhoto,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                  child: _logic.file == null
                      ? Icon(Icons.add)
                      : Image.file(_logic.file, fit: BoxFit.fill),
                  color: Palette.black26,
                  height: 100,
                  width: 100)),
        ),
        Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: MaterialButton(
                onPressed: _logic.removePhoto,
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
