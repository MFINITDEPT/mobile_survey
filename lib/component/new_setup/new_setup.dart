import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/component/new_setup/store/new_setup.dart';
import 'package:mobilesurvey/model/ao.dart';
import 'package:mobilesurvey/model/configuration.dart';
import 'package:mobilesurvey/model/photo_form.dart';
import 'package:mobilesurvey/model/quisioner.dart';
import 'package:mobilesurvey/model/zipcode.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/ui/interceptor.dart';
import 'package:mobilesurvey/ui/mobile_dashboard/login.dart';
import 'package:mobilesurvey/ui/mobile_survey/home_container.dart';
import 'package:mobilesurvey/ui/mobile_survey/login.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/shared_preferences_utils.dart';
import 'package:mobilesurvey/utilities/enum.dart';
import 'package:mobilesurvey/utilities/translation.dart';

import '../custom_button.dart';

typedef configuration = Future<dynamic> Function();

// ignore: public_member_api_docs
enum Status { failed, success, loading, dialog }

// ignore: public_member_api_docs, must_be_immutable
class NewSetup extends StatefulWidget {
  NewSetupController controller;
  configuration config;
  List<dynamic> fetchData;
  AppType appType;

  bool get isHasConfiguration => config != null;

  // ignore: public_member_api_docs
  NewSetup(
      {@required NewSetupController newSetupController,
      this.config,
      this.fetchData,
      this.appType})
      : assert(newSetupController != null),
        this.controller = newSetupController;

  @override
  State<StatefulWidget> createState() => _NewSetupState();
}

// ignore: prefer_mixin
class _NewSetupState extends State<NewSetup> with WidgetsBindingObserver {
  final NewSetupBase _logic = NewSetupBase();
  NewSetupController _controller;
  List<dynamic> _fetchData;

  @override
  void initState() {
    _controller = widget.controller;
    _controller.addListener(_update);
    if (widget.fetchData.isNotEmpty) {
      _fetchData = widget.fetchData;
      _controller._logic = _logic;
      _controller._totalApiRequest = _fetchData.length;

      if (widget.isHasConfiguration) {
        _fetchData.insert(0, widget.config);
        _controller._totalApiRequest += 1;
      }

      data(_fetchData);
    } else {
      delayed();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (_) {
        return Observer(builder: (_) {
          if (_logic.status == Status.failed) {
            return Center(
              child: AdvColumn(
                divider: ColumnDivider(16.0),
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(translation.getText('failed_get_data'),
                      textAlign: TextAlign.center),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      'try_again',
                      onPress: () => _retry(_fetchData),
                      buttonWidth: double.infinity,
                    ),
                  )
                ],
              ),
            );
          } else if (_logic.status == Status.loading) {
            return Center(
              child: AdvColumn(
                divider: ColumnDivider(4.0),
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  if (_controller.description != null)
                    Text(translation.getText(_controller.description))
                ],
              ),
            );
          } else if (_logic.status == Status.success) {
            return _successWidget(widget.appType);
          } else if (_logic.status == Status.dialog) {
            return LoginDashboardUI();
          } else {
            return Center(child: Text("something Error"));
          }
        });
      }),
    );
  }

  Widget _successWidget(AppType appType) {
    switch (widget.appType) {
      case AppType.survey:
        Widget page = PreferenceUtils.getString(kMobileSurveyUserId) != null
            ? HomeContainerUI()
            : LoginSurveyUI();
        return page;
      case AppType.collection:
        // TODO: Handle this case.
        break;
      case AppType.dashboard:
        return LoginDashboardUI();
      case AppType.approval:
        // TODO: Handle this case.
        break;
    }
  }

  void _update() {
    if (_controller.progress == 1.0) {
      if (_controller.checkDataIsNotValid()) {
        _logic.changeStatus(Status.failed);
      } else {
        _logic.changeStatus(Status.success);
      }
    } else {
      _logic.changeStatus(Status.loading);
    }
  }

  void _retry(List<dynamic> list) {
    _controller.retry();
    if (list.isNotEmpty) {
      data(list);
    } else {
      delayed();
    }
  }

  void data(List<dynamic> list) {
    switch (widget.appType) {
      case AppType.survey:
        fetchDataMobileSurvey(list);
        break;
      case AppType.collection:
        // TODO: Handle this case.
        break;
      case AppType.dashboard:
        delayed();
        break;
      case AppType.approval:
        // TODO: Handle this case.
        break;
    }
  }

  void delayed() {
    Future.delayed(Duration(seconds: 3))
        .then((value) => _logic.changeStatus(Status.success));
  }

  void fetchDataMobileSurvey(List<dynamic> list) async {
    if (widget.isHasConfiguration) {
      var config;
      var quesioner;
      var ao;
      var zipcode;
      var fotoForm;
      var docForm;

      if (_fetchData[0] is Future<ConfigurationModel> Function()) {
        config = _fetchData[0];
      }

      for (var i = 1; i < _fetchData.length; i++) {
        if (_fetchData[i] is Future<List<QuisionerModel>> Function()) {
          quesioner = _fetchData[i];
        } else if (_fetchData[i] is Future<List<ZipCodeModel>> Function()) {
          zipcode = _fetchData[i];
        } else if (_fetchData[i] is Future<List<AoModel>> Function()) {
          ao = _fetchData[i];
        } else if (_fetchData[i] is Future<List<PhotoForm>> Function(int id)) {
          fotoForm = _fetchData[i];
          docForm = _fetchData[i];
        }
      }

      config.call().then((value) {
        if (value == null) {
          _controller.updateProgress("get_configuration_error");
        } else {
          _controller.updateProgress("get_configuration_success",
              isGetDataSuccess: true);
          if (value.lastUpdateZipCode !=
              PreferenceUtils.getString(kLastUpdateZipCode)) {
            zipcode.call().then((value) {
              if (value == null) {
                _controller.updateProgress("get_zipcode_error");
              } else {
                _controller.updateProgress("get_zipcode_success",
                    isGetDataSuccess: true);
                MasterRepositories.saveZipCodes(value);
              }
            });
          } else {
            MasterRepositories.readFromHive(master.zipcode).then((value) =>
                _controller.updateProgress("get_local_success",
                    isGetDataSuccess: value ?? false));
          }

          if (value.lastUpdateQuestion !=
              PreferenceUtils.getString(kLastUpdateQuestion)) {
            quesioner.call().then((value) {
              if (value == null) {
                _controller.updateProgress("get_question_error");
              } else {
                _controller.updateProgress("get_question_success",
                    isGetDataSuccess: true);
                MasterRepositories.saveQuestion(value);
              }
            });
          } else {
            MasterRepositories.readFromHive(master.question).then((value) =>
                _controller.updateProgress("get_local_success",
                    isGetDataSuccess: value ?? false));
          }

          if (value.lastUpdateAo != PreferenceUtils.getString(kLastUpdateAO)) {
            ao.call().then((value) {
              if (value == null) {
                _controller.updateProgress("get_ao_error");
              } else {
                _controller.updateProgress("get_ao_success",
                    isGetDataSuccess: true);
                MasterRepositories.saveAO(value);
              }
            });
          } else {
            MasterRepositories.readFromHive(master.ao).then((value) =>
                _controller.updateProgress("get_ao_success",
                    isGetDataSuccess: value ?? false));
          }

          if (value.lastUpdateForm !=
              PreferenceUtils.getString(kLastUpdateForm)) {
            fotoForm.call(0).then((value) {
              if (value == null) {
                _controller.updateProgress("get_doc_failed");
              } else {
                MasterRepositories.savePhotoForm(value, master.doc);
                _controller.updateProgress("get_doc_success",
                    isGetDataSuccess: true);
              }
            });
            docForm.call(1).then((value) {
              if (value == null) {
                _controller.updateProgress("get_pic_failed");
              } else {
                MasterRepositories.savePhotoForm(value, master.pic);
                _controller.updateProgress("get_pic_success",
                    isGetDataSuccess: true);
              }
            });
          } else {
            MasterRepositories.readFromHive(master.pic).then((value) =>
                _controller.updateProgress("get_pic_success",
                    isGetDataSuccess: value ?? false));

            MasterRepositories.readFromHive(master.doc).then((value) =>
                _controller.updateProgress("get_pic_success",
                    isGetDataSuccess: value ?? false));
          }
          MasterRepositories.saveConfiguration(value);
        }
      });
    }
  }
}

// ignore: public_member_api_docs
class NewSetupController extends ValueNotifier<NewSetupEditingValue> {
  double get progress => value.progress;

  String get description => value.description;

  bool get isError => value.isError;

  List<bool> get apiResultList => _apiResult;

  int _totalApiRequest;

  List<bool> _apiResult = [];

  NewSetupBase _logic;

  void retry() {
    if (_totalApiRequest > 0) _apiResult.clear();
    _logic.changeStatus(Status.loading);
  }

  void showDialog() => _logic.changeStatus(Status.dialog);

  void updateProgress(String description, {bool isGetDataSuccess = false}) {
    _apiResult.add(isGetDataSuccess);
    var progress = _apiResult.length / _totalApiRequest;
    value = value.copyWith(
        description: description,
        progress: progress,
        isError: !isGetDataSuccess);
  }

  // ignore: public_member_api_docs
  bool checkDataIsNotValid() {
    return _apiResult.contains(false);
  }

  // ignore: public_member_api_docs
  NewSetupController({double progress, String description, bool isError})
      : super(progress == null && description == null && isError == null
            ? NewSetupEditingValue.empty
            : NewSetupEditingValue(
                progress: progress,
                description: description,
                isError: isError));

  // ignore: public_member_api_docs
  NewSetupController.fromValue(NewSetupEditingValue value)
      : super(value ?? NewSetupEditingValue.empty);

  // ignore: public_member_api_docs
  void clear() {
    value = NewSetupEditingValue.empty;
  }
}

@immutable
class NewSetupEditingValue {
  // ignore: public_member_api_docs
  const NewSetupEditingValue(
      {this.progress = 0.0, this.description, this.isError = false});

  final double progress;
  final String description;
  final bool isError;

  // ignore: public_member_api_docs
  static const NewSetupEditingValue empty = NewSetupEditingValue();

  NewSetupEditingValue copyWith(
      {double progress,
      String description,
      bool isError,
      List<bool> apiResultList}) {
    return NewSetupEditingValue(
      progress: progress,
      description: description,
      isError: isError,
    );
  }

  // ignore: public_member_api_docs
  NewSetupEditingValue.fromValue(NewSetupEditingValue copy)
      : this.progress = copy.progress,
        this.description = copy.description,
        this.isError = copy.isError;

  @override
  String toString() => '$runtimeType(progress: \u2524$progress\u251C,'
      ' description: \u2524$description\u251C, '
      'isError: \u2524$isError\u251C)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! NewSetupEditingValue) return false;
    final NewSetupEditingValue typedOther = other;
    return typedOther.progress == progress &&
        typedOther.description == description &&
        typedOther.isError == isError;
  }

  @override
  int get hashCode =>
      hashValues(progress.hashCode, description.hashCode, isError.hashCode);
}
