import 'package:flutter/material.dart';

class BaacNewsScreen extends StatefulWidget {
  BaacNewsScreen({Key key}) : super(key: key);

  @override
  _BaacNewsScreenState createState() => _BaacNewsScreenState();
}

class _BaacNewsScreenState extends State<BaacNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข่าวสาร'),
      ),
      body: Center(
        child: Text('เนื้อหาหน้าข่าวสาร'),
      ),
    );
  }
}