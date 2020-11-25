import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/ui/login.dart';
import 'package:mobilesurvey/ui/splashscreen.dart';
import 'package:mobilesurvey/utilities/api_request.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/translation.dart';
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
        totalApiRequest: 1,
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

    _widget = PreferenceUtils.getString(kUserId) != null
        ? HomeContainerUI()
        : LoginUI();

/*
    Future.delayed(Duration(seconds: 3))
        .then((value) => _controller.updateProgress("success", true));*/

    APIRequest.masterZipCode().then((value) {
      if (value == null) {
        _controller.updateProgress("get_zipcode_error", false);
      } else {
        _controller.updateProgress("get_zipcode_success", true);
        MasterRepositories.saveZipCodes(value);
      }
    });

/*    APIRequest.getCity().then((value) {
      if (value == null) {
        print("error 1");
        _controller.updateProgress(
            translation.getText('get_city_error'), false);
      } else {
        print("success 1");
        MasterRepositories.saveCities(value);
        _controller.updateProgress(
            translation.getText('get_city_success'), true);
      }
    });

    APIRequest.getBranch().then((value) {
      if (value == null) {
        print("error 2");
        _controller.updateProgress(
            translation.getText('get_branch_error'), false);
      } else {
        print("success 2");
        MasterRepositories.saveBranches(value);
        _controller.updateProgress(
            translation.getText('get_branch_success'), true);
      }
    });

    APIRequest.getPlat().then((value) {
      if (value == null) {
        print("error 3");
        _controller.updateProgress(
            translation.getText('get_plat_error'), false);
      } else {
        print("success 3");
        MasterRepositories.savePlat(value);
        _controller.updateProgress(
            translation.getText('get_plat_success'), true);
      }
    });

    APIRequest.getInsurance().then((value) {
      if (value == null) {
        print("error 4");
        _controller.updateProgress(
            translation.getText('get_insurance_error'), false);
      } else {
        print("success 4");
        MasterRepositories.saveInsurance(value);
        _controller.updateProgress(
            translation.getText('get_insurance_success'), true);
      }
    });

    APIRequest.getMerkFromMaster().then((value) {
      if (value == null) {
        print("error 5");
        _controller.updateProgress(
            translation.getText('get_merk_error'), false);
      } else {
        print("success 5");
        MasterRepositories.saveMerk(value);
        _controller.updateProgress(
            translation.getText('get_merk_success'), true);
      }
    });*/
  }
}
