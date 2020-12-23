import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/ui/home.dart';
import 'package:mobilesurvey/ui/login.dart';
import 'package:mobilesurvey/ui/splashscreen.dart';
import 'package:mobilesurvey/utilities/api_request.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/enum.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:pit_permission/pit_permission.dart';
import 'package:ridjnaelcrypt/ridjnaelcrypt.dart';

import 'component/adv_column.dart';
import 'component/custom_button.dart';
import 'component/setup.dart';
import 'ui/home_container.dart';
import 'utilities/assets.dart';
import 'utilities/shared_preferences_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    translation.init('en');
    runApp(ITrackApp());
  });
}

class ITrackApp extends StatefulWidget {
  @override
  _ITrackAppState createState() => _ITrackAppState();
}

class _ITrackAppState extends State<ITrackApp>
    with SingleTickerProviderStateMixin {
  Widget _widget = Container();
  SetupController _controller;

  @override
  void initState() {
    _controller = SetupController();

    Ridjnael.setIv = kRijndaelIV;
    Ridjnael.setKey = kRijndaelKey;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage(Assets.logo), context);
      precacheImage(AssetImage(Assets.splashscreen), context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Setup(
        uiBuilder: _uiBuilder,
        fetcher: _fetcher,
        localizationsDelegates: [FallbackLocalizationDelegate()],
        totalApiRequest: 4,
        theme: kTheme,
        controller: _controller);
  }

  Widget _uiBuilder(BuildContext context, double processing, String description,
      Status type) {
    switch (type) {
      case Status.success:
        return _widget;
        break;
      case Status.failed:
        return _buildFailed();
        break;
      default:
        return _buildProcessing();
        break;
    }
  }

  Widget _buildProcessing() {
    return SplashScreenUI(assetImage: AssetImage(Assets.splashscreen));
  }

  Widget _buildFailed() {
    return Scaffold(
        body: Center(
            child: AdvColumn(
      divider: ColumnDivider(16.0),
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(translation.getText('failed_get_data'),
            textAlign: TextAlign.center),
        CustomButton(
          'try_again',
          onpress: () => setState(() {
            _controller.retry();
          }),
          buttonWidth: double.infinity,
        )
      ],
    )));
  }

  Future<void> _fetcher() async {
    await PreferenceUtils.init();

    _widget = PreferenceUtils.getString(kUserId) != null ? HomeUI() : LoginUI();

    await PitPermission.requestSinglePermission(PermissionName.storage);
/*
    Future.delayed(Duration(seconds: 3))
        .then((value) => _controller.updateProgress("success", true));*/

/*    bool masterQuestionExist =
        await MasterRepositories.checkFileExist(master.question);
    bool masterZipCodeExist =
        await MasterRepositories.checkFileExist(master.zipcode);*/

    APIRequest.getConfiguration().then((value) {
      if (value == null) {
        debugPrint("error config");
        _controller.updateProgress("get_configuration_error", false);
      } else {
        debugPrint("success config");
        _controller.updateProgress("get_configuration_success", true);

        if (value.lastUpdateZipCode !=
            PreferenceUtils.getString(kLastUpdateZipCode)) {
          APIRequest.masterZipCode().then((value) {
            if (value == null) {
              debugPrint("error zipcode");
              _controller.updateProgress("get_zipcode_error", false);
            } else {
              debugPrint("success zipcode");
              _controller.updateProgress("get_zipcode_success", true);
              MasterRepositories.saveZipCodes(value);
            }
          });
        } else {
          debugPrint("anggapannya udah ada zipcode");
          MasterRepositories.readFromFile(master.zipcode).then((value) =>
              _controller.updateProgress("get_local_success", value ?? false));
          //ambil dari local storage, tapi cek dulu ada filenya apa engga
        }

        if (value.lastUpdateQuestion !=
            PreferenceUtils.getString(kLastUpdateQuestion)) {
          APIRequest.masterQuisioner().then((value) {
            if (value == null) {
              debugPrint("error question");
              _controller.updateProgress("get_question_error", false);
            } else {
              debugPrint("success question");
              _controller.updateProgress("get_question_success", true);
              MasterRepositories.saveQuestion(value);
            }
          });
        } else {
          debugPrint("anggapannya udah ada question");
          MasterRepositories.readFromFile(master.question).then((value) =>
              _controller.updateProgress("get_local_success", value ?? false));
          //ambil dari local storage, tapi cek dulu ada filenya apa engga
        }

        if (value.lastUpdateAo != PreferenceUtils.getString(kLastUpdateAO)) {
          APIRequest.masterAo().then((value) {
            if (value == null) {
              debugPrint("error ao");
              _controller.updateProgress("get_ao_error", false);
            } else {
              debugPrint("success ao");
              _controller.updateProgress("get_ao_success", true);
              MasterRepositories.saveAO(value);
            }
          });
        } else {
          debugPrint("anggapannya udah ada AO");
          MasterRepositories.readFromFile(master.ao).then((value) =>
              _controller.updateProgress("get_ao_success", value ?? false));
        }
        MasterRepositories.saveConfiguration(value);
      }
    });
    /* APIRequest.masterZipCode().then((value) {
      if (value == null) {
        print("error zipcode");
        _controller.updateProgress("get_zipcode_error", false);
      } else {
        print("success zipcode");
        _controller.updateProgress("get_zipcode_success", true);
        MasterRepositories.saveZipCodes(value);
      }
    });

    APIRequest.masterQuisioner().then((value) {
      if (value == null) {
        print("error question");
        _controller.updateProgress("get_question_error", false);
      } else {
        print("success question");
        _controller.updateProgress("get_question_success", true);
        MasterRepositories.saveQuestion(value);
      }
    });*/
  }
}
