import 'package:flutter/material.dart';

class EmployeeScreen extends StatefulWidget {
  EmployeeScreen({Key key}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('เนื้อหาหน้าข้อมูลพนักงาน'),
      ),
    );
  }
}