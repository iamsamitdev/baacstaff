import 'package:baacstaff/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:pin_view/pin_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinCodeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("ยืนยันรหัสเข้าใช้งาน"),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container (
        padding: EdgeInsets.all(10.0),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible (
              child: Column (
                children: <Widget>[
                  Container(margin: EdgeInsets.symmetric(vertical: 15.0)),
                  Icon(Icons.email, size: 100.0, color: Theme.of(context).primaryColor),
                  Container(margin: EdgeInsets.symmetric(vertical: 15.0)),
                  Container (
                    width: MediaQuery.of(context).size.width * 4/5,
                    child: Text (
                      "ป้อนรหัสที่ได้รับจากอีเมล์",
                      textAlign: TextAlign.center,
                      style: TextStyle (
                        fontSize: 22.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.teal
                      ),
                    ),
                  ),
                  Container (
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: PinView (
                      count: 6, // count of the fields, excluding dashes
                      autoFocusFirstField: true, 
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w500
                      ),             
                      submit: (String pin){
                       if(pin == '123456'){
                         _checkPincode(context);                         
                       }else{
                         Utility.getInstance()
                         .showAlertDialog(context, 'มีข้อผิดพลาด', 'รหัสยืนยันไม่ถูกต้อง ลองใหม่');
                       }
                      } // gets triggered when all the fields are filled
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      )
    );
  }
  
  void _checkPincode(BuildContext context) async{
    // สร้างตัวแปรเก็บข้อมูลแบบ SharedPreferrences
    SharedPreferences sharedPreferences = 
    await SharedPreferences.getInstance();
    sharedPreferences.setInt('storeStep', 2);
    // ส่งไปหน้า set password
    Navigator.pushReplacementNamed(context, '/setpassword');
  }

}

