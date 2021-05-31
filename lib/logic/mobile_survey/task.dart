import 'package:flutter/cupertino.dart';
import 'package:mobilesurvey/model/client_controllers.dart';
import 'package:mobilesurvey/model/mobile_survey/document_item.dart';
import 'package:mobilesurvey/model/mobile_survey/photo_result.dart';
import 'package:mobilesurvey/model/mobile_survey/quisioner_answer.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/hive_utils.dart';
import 'package:mobx/mobx.dart';

part 'task.g.dart';

class TaskBase = _TaskLogic with _$TaskBase;

abstract class _TaskLogic with Store {
  @observable
  ObservableList<ClientControllerModel> client = ObservableList.of([]);

  @observable
  ObservableList<PhotoResult> assetResult = ObservableList.of([]);

  @observable
  ObservableList<PhotoResult> documentResult = ObservableList.of([]);

  @observable
  ObservableList<QuisionerAnswerModel> quisioner = ObservableList.of([]);

  @computed
  bool get clientIsEmpty => client.isEmpty;

  @computed
  bool get assetResultIsEmpty => assetResult.isEmpty;

  @computed
  bool get documentResultIsEmpty => documentResult.isEmpty;

  @computed
  bool get quisionerIsEmpty => quisioner.isEmpty;

  @computed
  bool get checkAllEmpty =>
      client.isEmpty ||
      assetResult.isEmpty ||
      quisioner.isEmpty ||
      documentResult.isEmpty;

  @action
  void setClient(List<ClientControllerModel> model) =>
      client = ObservableList.of(model);

  @action
  void setAssetResult(List<PhotoResult> model) =>
      assetResult = ObservableList.of(model);

  @action
  void setDocumentResult(List<PhotoResult> model) =>
      documentResult = ObservableList.of(model);

  @action
  void setQuisioner(List<QuisionerAnswerModel> model) =>
      quisioner = ObservableList.of(model);

  List<ReactionDisposer> _disposer = [];

  final List<ClientControllerModel> _client = [
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'name'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'birth_location'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'effective_to'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'effective_from'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'address'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'identity_no'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'identity_city'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'birth_date'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'mother_name'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'rt'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'rw'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'zipcode'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'village'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'district'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'handphone_no'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'phone_no'),
    ClientControllerModel(
        controller: TextEditingController(), controllerName: 'fax')
  ];

  void setupReaction() {
    _disposer.add(autorun((_) {
      setClient(_client);
      var controllers = client.map((element) => element.controller).toList();
      var controllerNames =
          client.map((element) => element.controllerName).toList();

      HiveUtils.readFromBox(
          kLastSavedClient, controllers, controllerNames, "Client");

      for (var element in controllers) {
        element.addListener(() => HiveUtils.addListenner(kLastSavedClient,
            element, controllerNames[controllers.indexOf(element)], "Client"));
      }
    }));

    _disposer.add(autorun((_) {
      var newPhotoResult = <PhotoResult>[];

      for (var element in MasterRepositories.photoFormResult) {
        var _photoResult = PhotoResult();
        _photoResult.form = element.form;

        var item = List<DocumentItem>(element.result.length);
        for (var i = 0; i < element.result.length; i++) {
          var result = HiveUtils.readPhotoItemFromBox(
              kLastSavedClient, _photoResult.form, i, "foto");
          if (result != null) {
            item[i] = result;
          }
        }

        _photoResult.result = item;
        newPhotoResult.add(_photoResult);
      }

      MasterRepositories.setFotoResult(newPhotoResult);
      setAssetResult(newPhotoResult);
    }));

    _disposer.add(autorun((_) {
      var newPhotoResult = <PhotoResult>[];

      for (var element in MasterRepositories.docFormResult) {
        var _photoResult = PhotoResult();
        _photoResult.form = element.form;

        var item = List<DocumentItem>(element.result.length);
        for (var i = 0; i < element.result.length; i++) {
          var result = HiveUtils.readPhotoItemFromBox(
              kLastSavedClient, _photoResult.form, i, "dokumen");
          if (result != null) {
            item[i] = result;
          }
        }

        _photoResult.result = item;
        newPhotoResult.add(_photoResult);
      }

      MasterRepositories.setDocResult(newPhotoResult);
      setDocumentResult(newPhotoResult);
    }));

    _disposer.add(autorun((_) {
      var newQuisioner = [];
      for (var element in MasterRepositories.quisionerList) {
        var _quisioner = QuisionerAnswerModel();
        _quisioner.id = element.id;
        _quisioner.question = element.question;
        var newChoice;
        if (element.choice != null) {
          newChoice = HiveUtils.readChoiceFromHive(
              kLastSavedClient, element.choice,
              type: "quisioner");
        }

        _quisioner.choice = newChoice ?? element.choice;
        _quisioner.controller = element.controller;
        if (element.controller != null) {
          HiveUtils.readControllerFromHive(kLastSavedClient, element.controller,
              element.question, "quisioner");
        }
        newQuisioner.add(_quisioner);
      }
      setQuisioner(List<QuisionerAnswerModel>.from(newQuisioner));

      MasterRepositories.saveQuisioner =
          List<QuisionerAnswerModel>.from(newQuisioner);
    }));
  }
}
