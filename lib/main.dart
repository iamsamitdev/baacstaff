import 'package:baacstaff/routers.dart';
import 'package:baacstaff/themes/styles.dart';
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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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