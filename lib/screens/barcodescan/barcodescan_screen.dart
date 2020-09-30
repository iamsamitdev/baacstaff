import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class BarCodeScanScreen extends StatefulWidget {
  BarCodeScanScreen({Key key}) : super(key: key);

  @override
  _BarCodeScanScreenState createState() => _BarCodeScanScreenState();
}

class _BarCodeScanScreenState extends State<BarCodeScanScreen> {
  
  // สร้างตัวแปรไว้เก็บผลลัพธ์ที่ได้จากการแสกน
  ScanResult _barcode;
  String _barcodeData, _barcodeType;

  // สร้างฟังก์ชันสำหรับการสแกน
  Future scan() async{
    _barcode = await BarcodeScanner.scan();
    _barcodeData = _barcode.rawContent;
    _barcodeType = _barcode.type.toString();
    print(_barcodeData);
    print(_barcodeType);
  }

  @override
  void initState() {
    super.initState();
    scan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode and QR Code Scan'),
      ),
      body: Center(
        child: _barcodeData != null ? Text(
          _barcodeData,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ) : Text('No Data'),
      ),
    );
  }
}