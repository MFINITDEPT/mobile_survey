import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:location/location.dart';
import 'package:mobilesurvey/model/client_controllers.dart';
import 'package:mobilesurvey/model/mobile_survey/photo_result.dart';
import 'package:mobilesurvey/model/mobile_survey/quisioner_answer.dart';
import 'package:mobilesurvey/model/response.dart';
import 'package:mobilesurvey/ui/mobile_survey/home_container.dart';
import 'package:mobilesurvey/utilities/api_request.dart';
import 'package:mobilesurvey/utilities/ui_utils.dart';
import 'package:mobx/mobx.dart';
import 'package:pit_permission/pit_permission.dart';

part 'process.g.dart';

class ProcessBase = _ProcessLogic with _$ProcessBase;

abstract class _ProcessLogic with Store {
  @observable
  ObservableList<PhotoResult> assetResults = ObservableList.of([]);
  @observable
  ObservableList<PhotoResult> documentResults = ObservableList.of([]);

  @observable
  ObservableList<ClientControllerModel> client = ObservableList.of([]);

  @observable
  ObservableList<QuisionerAnswerModel> quisioner = ObservableList.of([]);

  @computed
  bool get clientIsEmpty =>
      client.where((element) => element.controller.text == '')?.length != 0;

  @computed
  int get assetsEmptyLength =>
      assetResults.where((element) => element.result.contains(null))?.length ??
      0;

  @computed
  int get documentEmptyLength =>
      documentResults
          .where((element) => element.result.contains(null))
          ?.length ??
      0;

  List<ReactionDisposer> _disposer = [];

  void setupReaction(
      {ObservableList client,
      ObservableList assets,
      ObservableList documents,
      ObservableList quisioner}) {
    _disposer.add(autorun((_) {
      setDocumentResult(documents);
    }));

    _disposer.add(autorun((_) {
      setAssetResult(assets);
    }));

    _disposer.add(autorun((_) {
      setClient(client);
    }));

    _disposer.add(autorun((_) {
      setQuisioner(quisioner);
    }));
  }

  @action
  void setAssetResult(ObservableList list) =>
      assetResults = ObservableList.of([...list]);

  @action
  void setDocumentResult(ObservableList list) =>
      documentResults = ObservableList.of([...list]);

  @action
  void setClient(ObservableList list) => client = ObservableList.of([...list]);

  @action
  void setQuisioner(ObservableList list) =>
      quisioner = ObservableList.of([...list]);

  void test(BuildContext context) async {
    var _getPermission = await getPermission(context);
    if (!_getPermission) return;

    var _location = Location();
    var _getLocation = await _location.getLocation();

    EasyLoading.show(dismissOnTap: false);
    List assets = [];
    List document = [];

    for (var item in assetResults) {
      for (var item2 in item.result) {
        if (item2 != null) {
          assets.add(item);
        }
      }
    }

    for (var item in documentResults) {
      for (var item2 in item.result) {
        if (item2 != null) {
          document.add(item);
        }
      }
    }

    APIResponse success = await APIRequest.proccessSurvey(
        clients: client,
        document: List<PhotoResult>.from(document),
        assets: List<PhotoResult>.from(assets),
        quisioner: quisioner,
        location: _getLocation);

    if (EasyLoading.isShow) EasyLoading.dismiss();

    if (success.status == '200') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomeContainerUI()),
          (route) => false);
    }
  }

  Future<bool> getPermission(BuildContext context) async {
    if (!await PitPermission.checkPermission(PermissionName.location)) {
      var _hasPermission =
          await PitPermission.requestSinglePermission(PermissionName.location);
      var _shouldShowRequest =
          await PitPermission.shouldShowRequestPermissionRationale(
              [PermissionName.location]);
      if (!_hasPermission && !_shouldShowRequest) {
        var result = await UIUtils.locationDialog(context);
        if (result) return Future.value(false);
      } else if (!_hasPermission) {
        var result = await UIUtils.locationDialog(context);
        if (result) return Future.value(false);
      } else {
        return Future.value(true);
      }
    } else {
      return Future.value(true);
    }
  }
}
