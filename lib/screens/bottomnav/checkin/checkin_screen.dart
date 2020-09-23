import 'package:baacstaff/models/TimeDetailModel.dart';
import 'package:baacstaff/services/rest_api.dart';
import 'package:baacstaff/utils/utility.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class CheckinScreen extends StatefulWidget {
  CheckinScreen({Key key}) : super(key: key);

  @override
  _CheckinScreenState createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {

  // สร้างฟังก์ชันอ่านข้อมูลที่ลงเวลาไว้
  getTimeDetail() async {
    var result = await Connectivity().checkConnectivity();
    if(result==ConnectivityResult.none){ // ไม่ได้ออนไลน์
      Utility.getInstance().showAlertDialog(
        context, 
        'ออฟไลน์', 
        'คุณยังไม่ได้เชื่อมต่ออินเตอร์เน็ต'
      );
    }else{
      var response = await CallAPI().getTimeDetail();
      print(response.first.empId);
      print(response.first.date);
      print(response.first.time);
      print(response.first.type);
    }
  }

  @override
  void initState() {
    super.initState();
    getTimeDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: CallAPI().getTimeDetail(),
          builder: (BuildContext context,
            AsyncSnapshot<List<TimeDetailModel>> snapshot){
              if(snapshot.hasError){
                // โหลดข้อมูลไม่สำเร็จ
                return Center(
                  child: Text('มีข้อผิดพลาด ${snapshot.error.toString()}')
                );
              }else if(snapshot.connectionState == ConnectionState.done){
                // โหลดข้อมูลเสร็จ
                List<TimeDetailModel> timedetails = snapshot.data;
                return _listViewTimeDetail(timedetails);
              }else{
                // ระหว่างการทำงาน
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
        )
      ),
    );
  }

  // สร้าง ListView แสดงรายการ TimeDetail
  Widget _listViewTimeDetail(List<TimeDetailModel> timedetail){
    return ListView.builder(
      itemCount: timedetail.length,
      itemBuilder: (context, index){
        TimeDetailModel timeDetailModel = timedetail[index];
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
                          Image.asset(
                            'assets/images/avatar.jpg',
                            width: 55,
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(timeDetailModel.type),
                        Text('วันที่ '+timeDetailModel.date),
                        Text('เวลา '+timeDetailModel.time)
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