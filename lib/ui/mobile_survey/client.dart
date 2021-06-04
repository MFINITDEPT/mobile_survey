import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/component/adv_dropdown.dart';
import 'package:mobilesurvey/component/adv_row.dart';
import 'package:mobilesurvey/logic/mobile_survey/client.dart';
import 'package:mobilesurvey/model/client_controllers.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/model/master_configuration/zipcode_item.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/translation.dart';

import 'package:mobilesurvey/utilities/enum.dart';
import 'package:mobx/mobx.dart';

class ClientUI extends StatefulWidget {
  final ObservableList<ClientControllerModel> list;

  const ClientUI({Key key, this.list}) : super(key: key);

  @override
  _ClientUIState createState() => _ClientUIState();
}

class _ClientUIState extends NewState<ClientUI> {
  final ClientBase _logic = ClientBase();

  @override
  void initState() {
    _logic.setupReaction(widget.list);
    super.initState();
  }

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_logic.clientIsEmpty) {
          return CircularProgressIndicator.adaptive();
        } else {
          return ListView(
            children: [
              _buildTextField(_logic.client
                  .firstWhere((element) => element.controllerName == 'name')),
              _buildTextField(
                  _logic.client.firstWhere(
                      (element) => element.controllerName == 'identity_no'),
                  type: inputType.nik),
              AdvRow(
                children: [
                  Expanded(
                      child: _buildTextField(
                          _logic.client.firstWhere((element) =>
                              element.controllerName == 'effective_from'),
                          disable: true,
                          type: inputType.year,
                          context: context)),
                  Expanded(
                      child: _buildTextField(
                          _logic.client.firstWhere((element) =>
                              element.controllerName == 'effective_to'),
                          disable: true,
                          type: inputType.year,
                          context: context)),
                ],
              ),
              _buildTextField(_logic.client.firstWhere(
                  (element) => element.controllerName == 'identity_city')),
              _buildTextField(_logic.client.firstWhere(
                  (element) => element.controllerName == 'birth_location')),
              _buildTextField(
                  _logic.client.firstWhere(
                      (element) => element.controllerName == 'birth_date'),
                  type: inputType.date,
                  disable: true,
                  context: context),
              _buildTextField(_logic.client.firstWhere(
                  (element) => element.controllerName == 'address')),
              _buildTextField(_logic.client.firstWhere(
                  (element) => element.controllerName == 'mother_name')),
              _buildTextField(
                  _logic.client
                      .firstWhere((element) => element.controllerName == 'rt'),
                  type: inputType.numeric),
              _buildTextField(
                  _logic.client
                      .firstWhere((element) => element.controllerName == 'rw'),
                  type: inputType.numeric),
              _buildTextField(
                  _logic.client.firstWhere(
                      (element) => element.controllerName == 'zipcode'),
                  type: inputType.zipcode1),
              _buildTextField(
                  _logic.client.firstWhere(
                      (element) => element.controllerName == 'village'),
                  type: inputType.zipcodeText,
                 /* disable: true*/),
              _buildTextField(
                  _logic.client.firstWhere(
                      (element) => element.controllerName == 'district'),
                  type: inputType.zipcodeText,
                  /*disable: true*/),
              _buildTextField(
                  _logic.client.firstWhere(
                      (element) => element.controllerName == 'handphone_no'),
                  type: inputType.phone),
              _buildTextField(
                  _logic.client.firstWhere(
                      (element) => element.controllerName == 'phone_no'),
                  type: inputType.phone),
              _buildTextField(_logic.client
                  .firstWhere((element) => element.controllerName == 'fax')),
            ],
          );
        }
      },
    );
  }

  Widget _buildTextField(ClientControllerModel model,
      {inputType type = inputType.none,
      bool disable = false,
      BuildContext context}) {
    TextInputType keyboardType;
    int length;

    switch (type) {
      case inputType.nik:
        keyboardType = TextInputType.number;
        length = 16;
        break;
      case inputType.phone:
        keyboardType = TextInputType.phone;
        length = 14;
        break;
      case inputType.numeric:
        keyboardType = TextInputType.number;
        break;
      case inputType.year:
        keyboardType = TextInputType.number;
        length = 4;
        break;
      case inputType.zipcode1:
        keyboardType = TextInputType.number;
        length = 6;
        break;
      case inputType.zipcodeText:
        keyboardType = TextInputType.text;
        break;
      default:
        keyboardType = TextInputType.text;
        break;
    }

    return AdvRow(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: [
        Expanded(
            child: TextField(
                style: TextStyle(fontSize: 14.0),
                decoration: InputDecoration(
                    enabled: false,
                    hintText: translation.getText(model.controllerName),
                    hintStyle: TextStyle(color: Palette.navy),
                    disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.gold))))),
        Expanded(
            flex: 2,
            child: InkWell(
              onTap: type == inputType.date || type == inputType.year
                  ? () => type == inputType.year
                      ? _logic.yearPicker(context, model.controller)
                      : _logic.datePicker(context)
                  : null,
              child:
                   type == inputType.zipcode && !disable
                  ? _autoComplete()
                  :
                  TextField(
                controller: model.controller,
                style: TextStyle(color: Palette.black, fontSize: 12.0),
                maxLength: length,
                enabled: !(disable),
                keyboardType: keyboardType,
                buildCounter:
                    (context, {currentLength, maxLength, isFocused}) => null,
                inputFormatters: [
                  if (keyboardType == TextInputType.number ||
                      keyboardType == TextInputType.phone)
                    FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.gold)),
                    disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.gold)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.gold))),
              ),
            )),
      ],
    );
  }

  Widget _autoComplete() {
    return AutoCompleteTextField<ZipCodeItem>(
        controller: _logic.client
            .firstWhere((element) => element.controllerName == 'zipcode')
            .controller,
        itemSubmitted: _logic.autoFill,
        key: null,
        suggestions: MasterRepositories.zipcodes,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        clearOnSubmit: false,
        submitOnSuggestionTap: true,
        itemBuilder: (context, item) => Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text("${item.kodePos} ${item.kelurahan} ${item.kecamatan}"),
            ),
        itemSorter: (item, compare) => item.kodePos.compareTo(compare.kodePos),
        itemFilter: _logic.actionFilter);
  }

  Widget _buildDropDown(SearchModel model) {
    return AdvColumn(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.title,
          style: TextStyle(fontSize: 14.0, color: Palette.navy),
        ),
        AdvDropdownButton(
            value: model.value,
            icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.arrow_drop_down)),
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
            onChanged: (c) => setState(() => model.value = c))
      ],
    );
  }
}
