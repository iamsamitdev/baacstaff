import 'package:baacstaff/models/BaacTimeDetailModel.dart';
import 'package:baacstaff/services/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _getIMEI, _getPass;

class ShowTimeDetail extends StatefulWidget {
  ShowTimeDetail({Key key}) : super(key: key);

  @override
  _ShowTimeDetailState createState() => _ShowTimeDetailState();
}

class _ShowTimeDetailState extends State<ShowTimeDetail> {

  SharedPreferences sharedPreferences;

  // ข้อมูล body payload สำหรับแนบไปกับ post
  var bodyData = {
      'imei': _getIMEI,
      'pass': _getPass
  };

  readEmployee() async{
      sharedPreferences = await SharedPreferences.getInstance();
      // อ่านข้อมูลจาก sharedPreferences ลงตัวแปร
      _getIMEI = sharedPreferences.getString('storeIMEI').toString();
      _getPass = sharedPreferences.getString('storePass').toString();
      // print(bodyData['imei']);
  }

  // ตัวแปรสำหรับไว้เก็บข้อมูลเช็ค pull to refresh
  List<dynamic> _timeDetails = [];
  Future<void> fetchTimeDetail() async {
    var response = await CallAPI().baacPostTimeDetail(bodyData);
    setState(() {
      _timeDetails = response;
    });

  }

  // สร้างฟังก์ชันอ่านข้อมูลที่ลงเวลาไว้
  // ฟังก์ชันสำหรับทดสอบเรียก Api
  // getTimeDetail() async {
  //   var response = await CallAPI().baacPostTimeDetail(bodyData);
  //   print(response);
  //   print(response.first.no);
  //   print(response.first.empId);
  //   print(response.first.type);
  //   print(response.first.date);
  //   print(response.first.time);
  // }
  
  @override
  void initState() {
    super.initState();
    readEmployee();
    // fetchTimeDetail();
    // getTimeDetail();
    // print(_getIMEI);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลการลงเวลาเข้าออกงาน'),
      ),
      body: _getIMEI == null ? Center(child: CircularProgressIndicator(),) : RefreshIndicator(
            onRefresh: fetchTimeDetail,
            child: Container(
            child: FutureBuilder(
              future: CallAPI().baacPostTimeDetail(bodyData),
                builder: (BuildContext context,
                  AsyncSnapshot<List<BaacTimeDetailModel>> snapshot){
                    if(snapshot.hasError){
                      // โหลดข้อมูลไม่สำเร็จ
                      return Center(
                        child: Text('มีข้อผิดพลาด ${snapshot.error.toString()}')
                      );
                    }else if(snapshot.connectionState == ConnectionState.done){
                      // โหลดข้อมูลเสร็จ
                      List<BaacTimeDetailModel> timedetails = snapshot.data;
                      return _listViewTimeDetail(timedetails);
                    }else{
                      // ระหว่างการทำงาน
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
            ),
          ),
      ),
    );
  }

  // สร้าง Widget List View ไว้สำหรับแสดงผล
  Widget _listViewTimeDetail(List<BaacTimeDetailModel> timedetails) {
    return ListView.builder(
        itemCount: timedetails.length,
        itemBuilder: (context, index) {
          BaacTimeDetailModel baacTimeDetailModel = timedetails[index];
          return Container(
          child: Card(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          Icon(Icons.access_time, size: 40,)
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(baacTimeDetailModel.type),
                        Text('วันที่ '+baacTimeDetailModel.date),
                        Text('เวลา '+baacTimeDetailModel.time)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

}