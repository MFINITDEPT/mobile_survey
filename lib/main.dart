import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:mobilesurvey/logic/translation_app.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/ui/splashscreen.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pit_permission/pit_permission.dart';
import 'package:provider/provider.dart';
import 'package:ridjnaelcrypt/ridjnaelcrypt.dart';

import 'model/master_configuration/form_upload_item.dart';
import 'model/master_configuration/quisioner_item.dart';
import 'model/master_configuration/zipcode_item.dart';
import 'model/mobile_survey/document_item.dart';
import 'utilities/assets.dart';
import 'utilities/shared_preferences_utils.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await translation.init('id');
    await PreferenceUtils.init();
    var result =
        await PitPermission.requestSinglePermission(PermissionName.storage);
    if (result) {
      getApplicationDocumentsDirectory().then((value) {
        Hive
          ..init(value.path)
          ..registerAdapter(ZipCodeItemAdapter())
          ..registerAdapter(FormUploadItemAdapter())
          ..registerAdapter(QuisionerItemAdapter())
          ..registerAdapter(DocumentItemAdapter())
          ..registerAdapter(SearchModelAdapter());

        MasterRepositories.hivePath = value.path;
        FlutterImageCompress.showNativeLog = true;
        runApp(App());
      });
    }
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
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // initialise the plugin. app_icon needs to be a added
  // as a drawable resource to the Android head project
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: _onSelectNotification);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.high, priority: Priority.high, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, data['title'], data['body'], platformChannelSpecifics,
      payload: 'item x');
}

Future<void> _onDidReceiveLocalNotification(
    int id, String title, String body, String payload) {
  print("title : $title, payload :$payload");
  return Future.value();
}

Future<void> _onSelectNotification(String payload) {
  print("ini payload :$payload");
  return Future.value();
}

/// Top Class Application.
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    Ridjnael.setIv = kRijndaelIV;
    Ridjnael.setKey = kRijndaelKey;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage(Assets.camera), context);
      precacheImage(AssetImage(Assets.splashscreen), context);
    });

    _firebaseMessaging.configure(
        onMessage: myBackgroundMessageHandler,
        onBackgroundMessage: myBackgroundMessageHandler,
        onLaunch: myBackgroundMessageHandler,
        onResume: myBackgroundMessageHandler);

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));

    _firebaseMessaging.onIosSettingsRegistered.listen((settings) {
      print("Settings registered: $settings");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TranslationApp>(
      create: (_) => TranslationApp(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [FallbackLocalizationDelegate()],
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('id', 'ID'), // Indonesia
        ],
        theme: kTheme,
        home: Builder(builder: (context) {
          return Consumer<TranslationApp>(
            builder: (_, model, child) {
              model.setOnLocaleChange();
              return _buildSplashScreen();
            },
          );
        }),
      ),
    );
  }

  Widget _buildSplashScreen() {
    return SplashScreenUI(assetImage: AssetImage(Assets.splashscreen));
  }
}
