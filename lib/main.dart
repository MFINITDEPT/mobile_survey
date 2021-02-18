import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:mobilesurvey/model/quisioner.dart';
import 'package:mobilesurvey/model/zipcode.dart';
import 'package:mobilesurvey/model/ao.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/ui/home.dart';
import 'package:mobilesurvey/ui/login.dart';
import 'package:mobilesurvey/ui/splashscreen.dart';
import 'package:mobilesurvey/utilities/api_request.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/enum.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pit_permission/pit_permission.dart';
import 'package:ridjnaelcrypt/ridjnaelcrypt.dart';

import 'component/adv_column.dart';
import 'component/custom_button.dart';
import 'component/setup.dart';
import 'utilities/assets.dart';
import 'utilities/shared_preferences_utils.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    translation.init('en');
    getExternalStorageDirectory().then((value) {
      Hive
        ..init(value.path)
        ..registerAdapter(QuisionerModelAdapter())
        ..registerAdapter(ZipCodeModelAdapter())
        ..registerAdapter(AoModelAdapter());
      runApp(ITrackApp());
    });
  });
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
    print("print data : $data");
    showNotification(data);
    return;
  }

  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
    print("notif : $notification");
    showNotification(notification);
    return;
  }

}

Future<void> showNotification(data) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  var initializationSettingsAndroid =
  new AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = new IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  var initializationSettings = new InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.high, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, data['title'], data['body'], platformChannelSpecifics,
        payload: 'item x');
}

Future onDidReceiveLocalNotification(int id, String title, String body, String payload) {
  print("title : $title, payload :$payload");
}

Future onSelectNotification(String payload) {
  print("ini payload :$payload");
}


class ITrackApp extends StatefulWidget {
  @override
  _ITrackAppState createState() => _ITrackAppState();
}

class _ITrackAppState extends State<ITrackApp>
    with SingleTickerProviderStateMixin {
  Widget _widget = Container();
  SetupController _controller;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    _controller = SetupController();

    Ridjnael.setIv = kRijndaelIV;
    Ridjnael.setKey = kRijndaelKey;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage(Assets.logo), context);
      precacheImage(AssetImage(Assets.splashscreen), context);
    });

    _firebaseMessaging.configure(
      onMessage:myBackgroundMessageHandler,
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch:myBackgroundMessageHandler,
      onResume: myBackgroundMessageHandler
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
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

    Timer t1 = Timer.periodic(Duration(seconds: 1), (timer) { });
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
          MasterRepositories.readFromHive(master.zipcode).then((value) =>
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
          MasterRepositories.readFromHive(master.question).then((value) =>
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
          MasterRepositories.readFromHive(master.ao).then((value) =>
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
