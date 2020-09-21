import 'package:flutter/material.dart';

class BenefitScreen extends StatefulWidget {
  BenefitScreen({Key key}) : super(key: key);

  @override
  _BenefitScreenState createState() => _BenefitScreenState();
}

class _BenefitScreenState extends State<BenefitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('เนื้อหาหน้าสวัสดิการ'),
      ),
    );
  }
}