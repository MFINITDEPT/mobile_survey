import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/component/adv_dropdown.dart';
import 'package:mobilesurvey/logic/quisioner.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/model/quisioner.dart';

class QuisionerUI extends StatefulWidget {
  @override
  _QuisionerUIState createState() => _QuisionerUIState();
}

class _QuisionerUIState extends NewState<QuisionerUI> {
  QuisionerBase _logic;

  @override
  void initState() {
    _logic = QuisionerBase(this);
    _logic.getData();
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (_) {
        if (_logic.model.length != 0) {
          return ListView.separated(
            padding: EdgeInsets.all(32.0),
            itemBuilder: (_, int index) => _buildQuisioner(_logic.model[index]),
            itemCount: _logic.model.length,
            separatorBuilder: (_, __) => Container(
              height: 1.0,
              padding: EdgeInsets.symmetric(vertical: 4.0),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _buildQuisioner(QuisionerModel model) {
    Widget _child = Container();
    TextEditingController controller = TextEditingController();
    if (model.choice.length != 0) {
      SearchModel searchModel = SearchModel(
          title: '', itemList: model.choice, value: model.choice.first);
      _child = _buildDropDown(searchModel);
    } else {
      _child = TextField(controller: controller);
    }

    return AdvColumn(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.question),
        _child,
      ],
    );
  }

  Widget _buildDropDown(SearchModel model) {
    return AdvColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.title),
        AdvDropdownButton(
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
            onChanged: (c) => print('hhhh $c'))
      ],
    );
  }

/* @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (_) {
        if (_logic?.model.length != 0) {
          return PageView(
           //   physics: NeverScrollableScrollPhysics(),
              children: List.generate(_logic?.model.length,
                  (index) => _buildQuisioner(_logic.model[index])));
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _buildQuisioner(QuisionerModel model) {
    Widget _child = Container();
    TextEditingController controller = TextEditingController();
    if (model.choice.length != 0) {
      SearchModel searchModel = SearchModel(
          title: '', itemList: model.choice, value: model.choice.first);
      _child = _buildDropDown(searchModel);
    } else {
      _child = TextField(controller: controller);
    }

    return Center(
      child: AdvColumn(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(model.question),
          _child,
          CustomButton("next", buttonWidth: double.infinity)
        ],
      ),
    );
  }

  Widget _buildDropDown(SearchModel model) {
    return AdvColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.title),
        AdvDropdownButton(
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
            onChanged: (c) =>
                print('hhhh $c') */ /*_logic.onSelectedValue(c, model)*/ /*)
      ],
    );
  }*/
}
