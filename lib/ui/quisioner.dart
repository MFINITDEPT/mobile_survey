import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/component/adv_dropdown.dart';
import 'package:mobilesurvey/logic/quisioner.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/model/quisioner.dart';
import 'package:mobilesurvey/model/quisioner_answer.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/translation.dart';

class QuisionerUI extends StatefulWidget {
  final List<QuisionerModel> model;

  const QuisionerUI({Key key, this.model}) : super(key: key);

  @override
  _QuisionerUIState createState() => _QuisionerUIState();
}

class _QuisionerUIState extends NewState<QuisionerUI> {
  QuisionerBase _logic;

  @override
  void initState() {
    _logic = QuisionerBase(this);
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (_) {
        if (_logic.quisioner.length != 0) {
          return Column(
            children: [Expanded(child: ListView.separated(
              padding: EdgeInsets.all(16.0),
              itemBuilder: (_, int index) => _buildQuisioner(_logic.quisioner[index]),
              itemCount: _logic.quisioner.length,
              separatorBuilder: (_, __) => Container(
                height: 2.0,
                color: Palette.gold,
                margin: EdgeInsets.symmetric(vertical: 4.0),
              ),
            )),],
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
    if(model.choice != null) {
      _child = _buildDropDown(model.choice);
      if(model.choice.value.contains(",")) {
        _optionChoice = TextField(controller: model.controller,  decoration: InputDecoration(hintText: translation.getText('global_hint')),);
      };
    } else {
      _child = TextField(controller : model.controller);
    }

    return Container(
      color: Palette.grey,
      child: AdvColumn(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(model.question),
          _child,
          if(_optionChoice is TextField) _optionChoice
        ],
      ),
    );
  }

  Widget _buildDropDown(SearchModel model) {
    return AdvDropdownButton(
        value: model.value,
        icon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.keyboard_arrow_down)),
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
        onChanged: (c) => _logic.onSelectedValue(c, model));
  }
}
