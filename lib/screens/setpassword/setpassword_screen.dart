import 'package:baacstaff/utils/passwordwidget.dart';
import 'package:baacstaff/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetPasswordScreen extends StatefulWidget {
  SetPasswordScreen({Key key}) : super(key: key);

  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  // สร้างตัวแปรสำหรับผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้รับค่าจากฟอร์ม
  String passwordText, passwordConfirmText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("กำหนดรหัสผ่านเพื่อใช้งาน")),
      ),
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: Form(
              key: formKey,
              child: ListView(
                children: [
                  PasswordField(
                    helperText: 'รหัสยาวไม่เกิน 6 หลัก',
                    labelText: 'กำหนดรหัสผ่านใช้งาน',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'กรอกรหัสผ่านก่อน';
                      } else if (value.length != 6) {
                        return 'กรุณาป้อนรหัสผ่านด้วยเลข 6 หลัก';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (String value){
                      setState(() {
                        this.passwordText = value;
                      });
                    },
                    onSaved: (value){
                      passwordText = value.trim();
                    },
                  ),
                  SizedBox(height: 10),
                  PasswordField(
                    helperText: 'รหัสยาวไม่เกิน 6 หลัก',
                    labelText: 'ยืนยันรหัสผ่านอีกครั้ง',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'กรอกรหัสผ่านก่อน';
                      } else if (value.length != 6) {
                        return 'กรุณาป้อนรหัสผ่านด้วยเลข 6 หลัก';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (String value){
                      setState(() {
                        this.passwordConfirmText = value;
                      });
                    },
                    onSaved: (value){
                      passwordConfirmText = value.trim();
                    },
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: RaisedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          if(passwordText != passwordConfirmText){
                            Utility.getInstance()
                            .showAlertDialog(context, 'มีข้อผิดพลาด', 'รหัสผ่านทั้ง 2 ช่องไม่ตรงกัน ลองใหม่');
                          }else{
                            // Call API
                            // ส่งไปหน้า Dashboard
                            _setPasswordSubmit(context);
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'บันทึกข้อมูล',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  // Set Password
  void _setPasswordSubmit(BuildContext context) async{
    SharedPreferences sharedPreferences = 
    await SharedPreferences.getInstance();

    sharedPreferences.setInt('storeStep', 3);
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

}
