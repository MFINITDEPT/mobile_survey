import 'package:flutter/material.dart';
import 'package:mobilesurvey/logic/client.dart';

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
    print("ke print lagi ? ");
    _logic = ClientBase(this, widget.nik, widget.nikDataModel);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _logic.checkData();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return ListView(
      children: [
        _buildTextField('name', _logic.name),
        _buildTextField('identity_no', _logic.identityNo),
        AdvRow(
          children: [
            Expanded(
                child: _buildTextField('effective_of', _logic.effectiveOf)),
            Expanded(child: _buildTextField('to', _logic.to)),
          ],
        ),
        _buildTextField('identity_city', _logic.identityCity),
        _buildTextField('birth_location', _logic.birthLocation),
        _buildTextField('birth_date', _logic.birthDate),
        _buildTextField('address', _logic.address),
        _buildTextField('mother_name', _logic.motherName),
        _buildTextField('rt', _logic.rt),
        _buildTextField('rw', _logic.rw),
        _buildTextField('zip_code', _logic.address),
        _buildTextField('village', _logic.address),
        _buildTextField('district', _logic.address),
        _buildTextField('handphone_no', _logic.handphoneNo),
        _buildTextField('phone_no', _logic.phoneNo),
        _buildTextField('fax', _logic.fax),
      ],
    );
  }

  Widget _buildTextField(String title, TextEditingController controller) {
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
            child: TextField(
              controller: controller,
              style: TextStyle(color: Palette.prime, fontSize: 14.0),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.prime)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.prime))),
            ))
      ],
    );
  }
}
