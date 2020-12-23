import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/component/adv_dropdown.dart';
import 'package:mobilesurvey/component/custom_button.dart';
import 'package:mobilesurvey/logic/new_client.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/model/zipcode.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/enum.dart';

import '../boilerplate/new_state.dart';
import '../component/adv_row.dart';
import '../model/nik_data.dart';
import '../utilities/palette.dart';
import '../utilities/translation.dart';

class NewClientUI extends StatefulWidget {
  final NikDataModel nikDataModel;
  final String nik;

  const NewClientUI({Key key, this.nikDataModel, this.nik}) : super(key: key);

  @override
  _ClientUIState createState() => _ClientUIState();
}

class _ClientUIState extends NewState<NewClientUI> {
  NewClient _logic;

  @override
  void initState() {
    _logic =
        NewClient(this, identityNo: widget.nik, nikModel: widget.nikDataModel);
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation.getText('client')),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              _buildTextField('prefix_salute', _logic.prefixSalute),
              _buildTextField('name', _logic.name),
              _buildTextField('suffix_salute', _logic.suffixSalute),
              _buildTextField('identity_no', _logic.nik, type: inputType.nik),
              AdvRow(
                children: [
                  Expanded(
                      child: _buildTextField('effective_of', _logic.effectiveOf,
                          type: inputType.date, disable: true)),
                  Expanded(
                      child: _buildTextField('to', _logic.expired,
                          type: inputType.date, disable: true)),
                ],
              ),
              _buildTextField('identity_city', _logic.identityCity),
              Observer(builder: (_) => _buildDropDown(_logic.ao)),
              _buildTextField('birth_location', _logic.birthLocation),
              _buildTextField('birth_date', _logic.birthDate,
                  type: inputType.date, disable: true),
              _buildTextField('address', _logic.address1),
              _buildTextField(null, _logic.address2),
              _buildTextField(null, _logic.address3),
              _buildTextField('mother_name', _logic.motherName),
              _buildTextField('rt', _logic.rt, type: inputType.numeric),
              _buildTextField('rw', _logic.rw, type: inputType.numeric),
              _buildTextField('zip_code', _logic.zipCode,
                  type: inputType.zipcode),
              _buildTextField('village', _logic.village,
                  type: inputType.zipcode, disable: true),
              _buildTextField('district', _logic.district,
                  type: inputType.zipcode, disable: true),
              _buildTextField('handphone_no', _logic.handphoneNo,
                  type: inputType.phone),
              _buildTextField('phone_area', _logic.phoneArea,
                  type: inputType.year),
              _buildTextField('phone_no', _logic.phoneNo,
                  type: inputType.phone),
              _buildTextField('fax', _logic.fax),
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              "submit",
              onpress: _logic.submit,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String title, TextEditingController controller,
      {inputType type = inputType.none, bool disable = false}) {
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
      default:
        keyboardType = TextInputType.text;
        break;
    }

    return AdvRow(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: [
        Expanded(
            child: title == null
                ? Container()
                : TextField(
                    style: TextStyle(fontSize: 14.0),
                    decoration: InputDecoration(
                        enabled: false,
                        hintText: translation.getText(title),
                        hintStyle: TextStyle(color: Palette.blue),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Palette.prime))))),
        Expanded(
            flex: 2,
            child: InkWell(
              onTap: type == inputType.date
                  ? () => _logic.datePicker(controller)
                  : null,
              child: type == inputType.zipcode && !disable
                  ? _autoComplete()
                  : TextField(
                      controller: controller,
                      style: TextStyle(color: Palette.prime, fontSize: 14.0),
                      maxLength: length,
                      enabled: !(disable),
                      keyboardType: keyboardType,
                      buildCounter: (BuildContext context,
                              {int currentLength,
                              int maxLength,
                              bool isFocused}) =>
                          null,
                      inputFormatters: [
                        if (keyboardType == TextInputType.number ||
                            keyboardType == TextInputType.phone)
                          FilteringTextInputFormatter.digitsOnly
                      ],
                      onSubmitted: title == 'name' ? _logic.onSubmitted : null,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Palette.prime)),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Palette.prime)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Palette.prime))),
                    ),
            )),
      ],
    );
  }

  Widget _autoComplete() {
    return AutoCompleteTextField<ZipCodeModel>(
        controller: _logic.zipCode,
        itemSubmitted: _logic.autoFill,
        key: null,
        suggestions: MasterRepositories.zipcodes,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        clearOnSubmit: false,
        submitOnSuggestionTap: true,
        itemBuilder: (BuildContext context, ZipCodeModel item) => Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text("${item.kodePos} ${item.kelurahan} ${item.kecamatan}"),
            ),
        itemSorter: (ZipCodeModel item, ZipCodeModel compare) =>
            item.kodePos.compareTo(compare.kodePos),
        itemFilter: _logic.actionFilter);
  }

  Widget _buildDropDown(SearchModel model) {
    return AdvColumn(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.title,
          style: TextStyle(fontSize: 14.0, color: Palette.blue),
        ),
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
                          style: TextStyle(fontSize: 11.0)),
                    ))),
            onChanged: _logic.onSelected)
      ],
    );
  }
}
