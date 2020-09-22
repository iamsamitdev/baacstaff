import 'package:baacstaff/models/RegisterModel.dart';
import 'package:baacstaff/services/rest_api.dart';
import 'package:baacstaff/utils/utility.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeDetailScreen extends StatefulWidget {
  EmployeeDetailScreen({Key key}) : super(key: key);

  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {

  // เรียกใช้ตัวแปร SharedPrefference
  SharedPreferences sharedPreferences;

  // ตัวแปรไว้ทดสอบอ่าน IMEI และ MAC Address
  String _getIMEI, _getMacAddress;

  // เรียกใช้ Model RegisterModel
  RegisterModel _dataEmployee; 

  @override
  void initState() { 
    super.initState();
    readEmplyee();
  }

  // Call API
  readEmplyee() async {
    // เช็คว่าเครื่องผู้ใช้ online หรือ offline
    var result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.none){ // ถ้า offline อยู่
      print('คุณยังไม่ได้เชื่อมต่ออินเตอร์เน็ต');
      // แสดง alert popup
      Utility.getInstance()
      .showAlertDialog(context, 'ออฟไลน์', 'คุณยังไม่ได้เชื่อมต่ออินเตอร์เน็ต');
    }else{
      sharedPreferences = await SharedPreferences.getInstance();
      // อ่านข้อมูลจาก sharedPreferences ลงตัวแปร
      _getIMEI = sharedPreferences.getString('storeIMEI').toString();
      _getMacAddress = sharedPreferences.getString('storeMac').toString();

      var empData = {
        "empid": sharedPreferences.getString('storeEmpID').toString(),
        "cizid": sharedPreferences.getString('storeCizID').toString()
      };
      try{
        var response = await CallAPI().getEmployee(empData);
        // print(response.data.firstname);
        setState(() {
          _dataEmployee = response;
        });
      }catch(error){
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลพนักงาน'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('ชื่อ-สกุล'),
            subtitle: Text('${_dataEmployee?.data?.firstname ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('รหัสพนักงาน'),
            subtitle: Text('${_dataEmployee?.data?.empid ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Text('เพศ'),
            subtitle: Text('${_dataEmployee?.data?.gender ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('ตำแหน่ง'),
            subtitle: Text('${_dataEmployee?.data?.position ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('สังกัด'),
            subtitle: Text('${_dataEmployee?.data?.department ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('เงินเดือน'),
            subtitle: Text('${_dataEmployee?.data?.salary ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text('วันเกิด'),
            subtitle: Text('${_dataEmployee?.data?.birthdate ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('อีเมล์'),
            subtitle: Text('${_dataEmployee?.data?.email ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('เบอร์โทรศัพท์'),
            subtitle: Text('${_dataEmployee?.data?.tel ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('ที่อยู่'),
            subtitle: Text('${_dataEmployee?.data?.address ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('IMEI'),
            subtitle: Text('${_getIMEI ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Mac Address'),
            subtitle: Text('${_getMacAddress ?? "..."}'),
          ),
        ],
      ),
    );
  }
}