import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/model/nik_data.dart';
import 'package:mobilesurvey/model/zipcode.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/api_request.dart';
import 'package:mobilesurvey/utilities/date_utils.dart';
import 'package:mobilesurvey/utilities/string_utils.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobx/mobx.dart';

part 'new_client.g.dart';

class NewClient = _NewClientBase with _$NewClient;

abstract class _NewClientBase with Store {
  _NewClientBase(NewState state, {NikDataModel nikModel, String identityNo}) {
    this._state = state;
    this._model = nikModel;
    this._nik = identityNo;

    when((_) => _model != null, () {
      name.text = _model.namaLengkap;
      birthLocation.text = _model.tempatLahir;
      birthDate.text = _model.tanggalLahir;
      address1.text = _model.alamat;
      address2.text = _model.kelurahanName;
      address3.text = _model.kecamatanName;
      rt.text = _model.nomorRt;
      rw.text = _model.nomorRw;
      nik.text = _nik;

      Fluttertoast.showToast(msg: translation.getText('verified_by_dukcapil'));
//      Future.delayed(Duration(seconds: 3)).then((value) =>);
    });
  }

  NewState _state;
  @observable
  NikDataModel _model;
  String _nik;

  BuildContext get _context => _state.context;

  TextEditingController name = TextEditingController();
  TextEditingController prefixSalute = TextEditingController();
  TextEditingController suffixSalute = TextEditingController();
  TextEditingController birthLocation = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController address3 = TextEditingController();
  TextEditingController effectiveOf = TextEditingController();
  TextEditingController expired = TextEditingController();
  TextEditingController identityCity = TextEditingController();
  TextEditingController motherName = TextEditingController();
  TextEditingController rt = TextEditingController();
  TextEditingController rw = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController village = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController handphoneNo = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController phoneArea = TextEditingController();
  TextEditingController fax = TextEditingController();

  static List<String> _aoList =
      MasterRepositories.ao.map((e) => e.descs).toList();

  @observable
  SearchModel ao = SearchModel(
      title: translation.getText('ao'),
      itemList: _aoList,
      value: _aoList.first);

  @action
  Future<void> datePicker(TextEditingController controller) async {
    FocusScope.of(_context).unfocus();
    var finalResult = await DatePicker.showSimpleDatePicker(
      _context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );

    controller.text = finalResult != null
        ? StringUtils.formatDate(finalResult)
        : controller.text;
  }

  @action
  void autoFill(ZipCodeModel item) {
    zipCode.text = item.kodePos;
    district.text = item.kelurahan;
    village.text = item.kecamatan;
  }

  @action
  bool actionFilter(ZipCodeModel item, String query) {
    district.text = '';
    village.text = '';
    return item.kodePos.startsWith(query);
  }

  @action
  void onSelected(String selected) {
    ao = SearchModel(title: ao.title, itemList: ao.itemList, value: selected);
  }

  @action
  void submit() {
    if (name.text == '' ||
        prefixSalute.text == '' ||
        suffixSalute.text == '' ||
        nik.text == '' ||
        birthDate.text == '' ||
        birthLocation.text == '' ||
        motherName.text == '' ||
        rt.text == '' ||
        rw.text == '' ||
        address1.text == '' ||
        address2.text == '' ||
        address3.text == '' ||
        identityCity.text == '' ||
        effectiveOf.text == '' ||
        expired.text == '') {
      Fluttertoast.showToast(msg: 'Harap isi semua field');
      return;
    }

    _state.process(() async {
      var res = await APIRequest.checkDuplicateName(name.text);
      if (res.toString() != "Success") {
        await Fluttertoast.showToast(
            msg: res.toString(), toastLength: Toast.LENGTH_LONG);
        return;
      }

      var finalRes = await APIRequest.insertIntoMsix(
          name: name.text,
          prefixSalute: prefixSalute.text,
          suffixSalute: suffixSalute.text,
          identityCity: identityCity.text,
          identityNo: nik.text,
          birthLocation: birthLocation.text,
          motherName: motherName.text,
          rt: rt.text,
          rw: rw.text,
          address1: address1.text,
          address2: address2.text,
          address3: address3.text,
          ao: ao.value,
          zipcode: zipCode.text,
          village: village.text,
          district: district.text,
          birthDate: DateUtils.convertStringDate(birthDate.text),
          expiredOf: DateUtils.convertStringDate(expired.text),
          validOf: DateUtils.convertStringDate(effectiveOf.text),
          phoneArea: phoneArea.text,
          phoneNo: phoneNo.text,
          fax: fax.text,
          handphoneNo: handphoneNo.text);
      Fluttertoast.showToast(
          msg: finalRes.toString(), toastLength: Toast.LENGTH_LONG);
      if (finalRes.toString() == "Success") Navigator.pop(_context);
    });
  }

  @action
  void onSubmitted(String name) {
    _state.process(() async {
      var msg = await APIRequest.checkDuplicateName(name);
      Fluttertoast.showToast(msg: msg);
    });
  }
}
