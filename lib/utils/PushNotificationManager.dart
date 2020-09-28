import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManager {

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  void initFirebaseMessaging() {
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
  );

  firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true));
  firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
    print("Settings registered: $settings");
  });

  firebaseMessaging.getToken().then((String token) {
    assert(token != null);
    print("Token : $token");
  });

  }

}