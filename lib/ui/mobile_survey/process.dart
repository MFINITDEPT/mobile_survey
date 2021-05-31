import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/component/custom_button.dart';
import 'package:mobilesurvey/logic/mobile_survey/process.dart';
import 'package:mobilesurvey/model/client_controllers.dart';
import 'package:mobilesurvey/model/mobile_survey/photo_result.dart';
import 'package:mobilesurvey/model/mobile_survey/quisioner_answer.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobx/mobx.dart';

class ProcessUI extends StatefulWidget {
  final ObservableList<ClientControllerModel> client;
  final ObservableList<QuisionerAnswerModel> quisioner;
  final ObservableList<PhotoResult> assets;
  final ObservableList<PhotoResult> documents;

  const ProcessUI(
      {Key key, this.client, this.quisioner, this.assets, this.documents})
      : super(key: key);

  @override
  _ProcessUIState createState() => _ProcessUIState();
}

class _ProcessUIState extends State<ProcessUI> {
  final ProcessBase _logic = ProcessBase();

  @override
  void initState() {
    _logic.setupReaction(
        client: widget.client,
        quisioner: widget.quisioner,
        documents: widget.documents,
        assets: widget.assets);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Observer(builder: (_) {
              return _buildItem(
                  "Quisioner", _logic.clientIsEmpty ? "Process" : "Done");
            }),
            Observer(builder: (_) {
              return _buildItem(
                  "Assets",
                  _logic.assetsEmptyLength == 0
                      ? "Done"
                      : "Process ${_logic.assetResults.length - _logic.assetsEmptyLength}/${_logic.assetResults.length}");
            }),
            Observer(builder: (_) {
              return _buildItem(
                  "Document",
                  _logic.documentEmptyLength == 0
                      ? "Done"
                      : "Process ${_logic.documentResults.length - _logic.documentEmptyLength}/${_logic.documentResults.length}");
            }),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: CustomButton(
                "submit",
                onPress: () => _logic.test(context),
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
