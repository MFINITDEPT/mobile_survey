import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilesurvey/logic/client.dart';
import 'package:mobilesurvey/model/zipcode.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/enum.dart';

import '../boilerplate/new_state.dart';
import '../component/adv_row.dart';
import '../model/nik_data.dart';
import '../utilities/palette.dart';
import '../utilities/translation.dart';

class ClientUI extends StatefulWidget {
  final NikDataModel nikDataModel;
  final String nik;

  const ClientUI({Key key, this.nikDataModel, this.nik}) : super(key: key);

  @override
  _ClientUIState createState() => _ClientUIState();
}

class _ClientUIState extends NewState<ClientUI> {
  ClientBase _logic;

  @override
  void initState() {
    _logic = ClientBase(this, widget.nik, widget.nikDataModel);

    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return ListView(
      children: [
        _buildTextField('name', _logic.name),
        _buildTextField('identity_no', _logic.identityNo, type: inputType.nik),
        AdvRow(
          children: [
            Expanded(
                child: _buildTextField('effective_of', _logic.effectiveOf,
                    type: inputType.year)),
            Expanded(
                child: _buildTextField('to', _logic.to, type: inputType.year)),
          ],
        ),
        _buildTextField('identity_city', _logic.identityCity),
        _buildTextField('birth_location', _logic.birthLocation),
        _buildTextField('birth_date', _logic.birthDate,
            type: inputType.date, disable: true),
        _buildTextField('address', _logic.address),
        _buildTextField('mother_name', _logic.motherName),
        _buildTextField('rt', _logic.rt, type: inputType.numeric),
        _buildTextField('rw', _logic.rw, type: inputType.numeric),
        _buildTextField('zip_code', _logic.zipcode, type: inputType.zipcode),
        _buildTextField('village', _logic.village,
            type: inputType.zipcode, disable: true),
        _buildTextField('district', _logic.district,
            type: inputType.zipcode, disable: true),
        _buildTextField('handphone_no', _logic.handphoneNo,
            type: inputType.phone),
        _buildTextField('phone_no', _logic.phoneNo, type: inputType.phone),
        _buildTextField('fax', _logic.fax),
      ],
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

    print("astoge $title ${!disable} $type");

    return AdvRow(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: [
        Expanded(
            child: TextField(
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
              onTap: type == inputType.date ? () => _logic.datePicker() : null,
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
        controller: _logic.zipcode,
        itemSubmitted: _logic.autoFill,
        key: null,
        suggestions: MasterRepositories.zipcodes,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        clearOnSubmit: false,
        submitOnSuggestionTap: true,
        itemBuilder: (BuildContext context, ZipCodeModel item) =>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${item.kodePos} ${item.kota} ${item.kecamatan}"),
            ),
        itemSorter: (ZipCodeModel item, ZipCodeModel compare) =>
            item.kodePos.compareTo(compare.kodePos),
        itemFilter: (ZipCodeModel item, String query) =>
            item.kodePos.startsWith(query));
  }
}
