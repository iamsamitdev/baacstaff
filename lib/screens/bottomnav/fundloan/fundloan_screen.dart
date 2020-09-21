import 'package:flutter/material.dart';

class FundLoanScreen extends StatefulWidget {
  FundLoanScreen({Key key}) : super(key: key);

  @override
  _FundLoanScreenState createState() => _FundLoanScreenState();
}

class _FundLoanScreenState extends State<FundLoanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('เนื้อหาหน้ากองทุน'),
      ),
    );
  }
}