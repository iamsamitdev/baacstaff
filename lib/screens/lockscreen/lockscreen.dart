import 'package:baacstaff/screens/lockscreen/numpad.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockScreen extends StatefulWidget {

  LockScreen({Key key}) : super(key: key);

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {

  int length = 6;

  SharedPreferences sharedPreferences;

  // ฟังก์ชันเข้าระบบ
  signIn() async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('storeStep', 3);
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  onChange(String number){
    if(number.length == length){

      print(number);
      // ส่งไปเช็ค pin ที่ API ตรงส่วนนี้
      // ส่งไปหน้า DashBoard
      signIn();

    }
    // print(number);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Lock Screen'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(right: 20),
            //       child: IconButton(icon: Icon(Icons.close), onPressed: (){})
            //     ),
            //   ],
            // ),
            Image.asset(
              'assets/images/astaff_logo.png',
              width: 80,
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'กรุณาใส่รหัสผ่าน',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.black),
              ),
            ),
            Numpad(length: length, onChange: onChange,)
          ],
        ),
      ),
    );
  }
}