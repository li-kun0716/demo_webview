import 'package:firebase_messaging/firebase_messaging.dart';

void initFCM() async {
  print("tag-initFCM");
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    await messaging.getAPNSToken();
  } else {
    print('User declined or has not accepted permission');
  }
  final fcmToken = await FirebaseMessaging.instance.getToken().catchError((e) {
    print("fcmToken error: $e");
    return null;
  });
  if (fcmToken == null) {
    print("fcmToken is null");
    return;
  }
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
    print("fcmToken: $fcmToken");
  }).onError((err) {
    print("fcmToken onTokenRefresh error: $err");
  });

  print("initFCM fcmToken: $fcmToken");
}
