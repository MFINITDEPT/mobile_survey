import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../component/adv_column.dart';
import '../component/adv_dropdown.dart';
import '../logic/mobile_survey/client.dart';
import '../model/dropdown.dart';
import '../model/zipcode.dart';
import '../repositories/master.dart';
import '../utilities/enum.dart';

import '../boilerplate/new_state.dart';
import '../component/adv_row.dart';
import '../utilities/palette.dart';
import '../utilities/translation.dart';

// ignore: public_member_api_docs
class ClientUI extends StatefulWidget {
  ///Client UI
  const ClientUI({Key key}) : super(key: key);

  @override
  _ClientUIState createState() => _ClientUIState();
}

class _ClientUIState extends NewState<ClientUI> {
  final ClientBase _logic = ClientBase();

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
                    disable: true, type: inputType.year, context: context)),
            Expanded(
                child: _buildTextField('to', _logic.to,
                    disable: true, type: inputType.year, context: context)),
          ],
        ),
        _buildTextField('identity_city', _logic.identityCity),
       /* Observer(builder: (_) => _buildDropDown(_logic.ao)),*/
        _buildTextField('birth_location', _logic.birthLocation),
        _buildTextField('birth_date', _logic.birthDate,
            type: inputType.date, disable: true, context: context),
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
                    hintText: translation.getText(title),
                    hintStyle: TextStyle(color: Palette.navy),
                    disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.gold))))),
        Expanded(
            flex: 2,
            child: InkWell(
              onTap: type == inputType.date || type == inputType.year
                  ? () => type == inputType.year
                      ? _logic.yearPicker(context, controller)
                      : _logic.datePicker(context)
                  : null,
              child: type == inputType.zipcode && !disable
                  ? _autoComplete()
                  : TextField(
                      controller: controller,
                      style: TextStyle(color: Palette.black, fontSize: 12.0),
                      maxLength: length,
                      enabled: !(disable),
                      keyboardType: keyboardType,
                      buildCounter: (context,
                              {currentLength, maxLength, isFocused}) =>
                          null,
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
    return AutoCompleteTextField<ZipCodeModel>(
        controller: _logic.zipcode,
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
