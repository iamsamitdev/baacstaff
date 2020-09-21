import 'package:flutter/material.dart';

class CheckinScreen extends StatefulWidget {
  CheckinScreen({Key key}) : super(key: key);

  @override
  _CheckinScreenState createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('เนื้อหาหน้าลงเวลาทำงาน'),
      ),
    );
  }
}