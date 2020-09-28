import 'dart:io';

import 'package:baacstaff/routers.dart';
import 'package:baacstaff/themes/styles.dart';
import 'package:baacstaff/utils/PushNotificationManager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var storeStep;
var initURL;

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = 
  await SharedPreferences.getInstance();

  storeStep = sharedPreferences.getInt('storeStep');

  if(storeStep == 1){
    initURL = '/pincode';
  }else if(storeStep == 2){
    initURL = '/setpassword';
  }else if(storeStep == 3){
    initURL = '/dashboard';
  }else if(storeStep == 4){
    initURL = '/lockscreen';
  }else{
    initURL = '/welcome';
  }

  HttpOverrides.global = new MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() { 
    super.initState();
    // Call Pushnotification
    PushNotificationManager().initFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: initURL,
      routes: routes,
    );
  }
}

// เขียน class ข้ามการตรวจ Certificate https
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
    ..badCertificateCallback = 
    (X509Certificate cert, String host, int port)=>true;
  }
}