import 'package:flutter/cupertino.dart';
import 'package:mobilesurvey/model/client_controllers.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/hive_utils.dart';
import 'package:mobx/mobx.dart';

part 'task.g.dart';

class TaskBase = _TaskLogic with _$TaskBase;

abstract class _TaskLogic with Store {
/*  final _dispose = autorun((_) {
    MasterRepositories.getAssetsPhoto();
    MasterRepositories.getDocumentPhoto();
  });*/

  @observable
  ObservableList<ClientControllerModel> client = ObservableList.of([]);

  @computed
  bool get clientIsEmpty => client.isEmpty;

  @action
  void setClient(List<ClientControllerModel> model) =>
      client = ObservableList.of(model);

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

    _disposer.add(autorun((_){
      MasterRepositories.getAssetsPhoto();
    }));
  }
}
