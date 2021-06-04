import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobilesurvey/utilities/notification_helper.dart';

class FirebaseRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void subscibeToTopic({String topic = 'job'}) =>_firebaseMessaging.subscribeToTopic(topic);

  Future<String> getToken() async => await _firebaseMessaging.getToken();

  void firebaseConfigure() {
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      print("message initial message : ${value?.data}");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message : ${message.data}");
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print("disini");
      NotificationHelper.showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      NotificationHelper.showNotification(message);
//  Navigator.pushNamed(context, '/message',
//          arguments: MessageArguments(message, true));

    });
  }
}