import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:mobilesurvey/logic/translation_app.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/repositories/firebase.dart';
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
import 'package:mobilesurvey/utilities/notification_helper.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  NotificationHelper.showNotification(message);
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await translation.init('id');
    await PreferenceUtils.init();
    await Firebase.initializeApp();
    await NotificationHelper.setNotification();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    Ridjnael.setIv = kRijndaelIV;
    Ridjnael.setKey = kRijndaelKey;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage(Assets.camera), context);
      precacheImage(AssetImage(Assets.splashscreen), context);
    });

    FirebaseRepository().firebaseConfigure();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TranslationApp>(
      create: (_) => TranslationApp(),
      child: MaterialApp(
        builder: EasyLoading.init() ,
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
