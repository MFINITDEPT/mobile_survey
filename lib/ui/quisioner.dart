import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/component/adv_dropdown.dart';
import 'package:mobilesurvey/component/custom_textfield.dart';
import 'package:mobilesurvey/logic/quisioner.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/model/quisioner.dart';
import 'package:mobilesurvey/model/quisioner_answer.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/translation.dart';

// ignore: public_member_api_docs
class QuisionerUI extends StatefulWidget {
  final List<QuisionerModel> model;

  // ignore: public_member_api_docs
  const QuisionerUI({Key key, this.model}) : super(key: key);

  @override
  _QuisionerUIState createState() => _QuisionerUIState();
}

class _QuisionerUIState extends NewState<QuisionerUI> {
  final QuisionerBase _logic = QuisionerBase();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (_) {
        if (_logic.quisioner.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.all(16.0),
                      itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: _buildQuisioner(_logic.quisioner[index]),
                          ),
                      itemCount: _logic.quisioner.length)),
            ],
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _buildQuisioner(QuisionerAnswerModel model) {
    Widget _child = Container();
    Widget _optionChoice = Container();
    if (model.choice != null) {
      _child = _buildDropDown(model.choice);
      if (model.choice.value.contains(",")) {
        _optionChoice = CustomTextField(
            controller: model.controller,
            title: translation.getText('global_hint'));
      }
    } else {
      _child = CustomTextField(
          padding: 0.0,
          controller: model.controller,
          title: translation.getText('global_hint'));
    }

    return AdvColumn(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.question, style: TextStyle(color: Palette.navy)),
        _child,
        if (_optionChoice is CustomTextField) _optionChoice
      ],
    );
  }

  Widget _buildDropDown(SearchModel model) {
    return AdvDropdownButton(
        value: model.value,
        icon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.arrow_drop_down, color: Palette.gold)),
        isExpanded: true,
        outerActions: AdvDropdownAction(),
        items: List.generate(
            model.itemList.length,
            (index) => AdvDropdownMenuItem(
                value: model.itemList[index],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(model.itemList[index],
                      style: TextStyle(fontSize: 12.0)),
                ))),
        onChanged: (c) => _logic.onSelectedValue(setState,c, model));
  }
}
