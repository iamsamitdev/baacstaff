import 'package:baacstaff/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final String _currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final String _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
  final List<int> numbers = [1, 2, 3, 5, 8];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
         Container(
           width: double.infinity,
           height: 120.0,
           decoration: BoxDecoration(
             image: DecorationImage(
                 image: AssetImage('assets/images/bg_account.jpg'),
                 fit: BoxFit.cover
               )
           ),
           child: Padding(
             padding: const EdgeInsets.all(15.0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Row(
                   children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Color(0xffffffff),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage('assets/images/avatar.jpg'),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('สวัสดี', style: TextStyle(fontSize: 18, color: Colors.white),),
                          Text('สามิตร โกยม', style: TextStyle(fontSize: 20, color: Colors.white),),
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          RaisedButton(
                            onPressed: (){

                              showDialog(
                                context: context,
                                builder: (BuildContext context) => SimpleDialog(
                                  // title: Text('เลือกลงเวลาทำงาน'),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('วันที่ $_currentDate'),
                                          Text('เวลา $_currentTime')
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.work),
                                      title: Text('ลงเวลาเข้าทำงาน'),
                                      onTap: () { 
                                        Utility.getInstance().showAlertDialog(context, 'เรียบร้อย', 'บันทึกข้อมูลเวลาเข้าทำงานเรียบร้อยแล้ว');
                                        // Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.time_to_leave),
                                      title: Text('ลงเวลาออกงาน'),
                                      onTap: () { 
                                        Utility.getInstance().showAlertDialog(context, 'เรียบร้อย', 'บันทึกข้อมูลเวลาออกงานเรียบร้อยแล้ว');
                                        // Navigator.pop(context);
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      // mainAxisSize: MainAxisSize.max,
                                      children: [
                                        OutlineButton(
                                          child: Icon(Icons.close, size: 20,), 
                                          color: Colors.red,
                                          textColor: Colors.black,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )

                              );

                            },
                            child: Text('ลงเวลาทำงาน', style: TextStyle(color: Colors.white),),
                            color: Colors.red,
                          )
                        ],
                      ),
                    )
                      
                   ],

                 ),
               ],
             ),
           ),
         ),
         Padding(
           padding: const EdgeInsets.only(top:15.0, left: 15.0, bottom: 15.0),
           child: Text('ข่าวประกาศล่าสุด', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
         ),
         Container(
           height: MediaQuery.of(context).size.height * 0.25,
           child: ListView.builder(
           scrollDirection: Axis.horizontal,
           itemCount: numbers.length, itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Card(
                  color: Colors.green,
                  child: Container(
                    child: Center(child: Text(numbers[index].toString(), style: TextStyle(color: Colors.white, fontSize: 36.0),)),
                  ),
                ),
              );
            }
          ),
         ),
         Padding(
           padding: const EdgeInsets.only(top:15.0, left: 15.0, bottom: 15.0),
           child: Text('ข่าวทั้งหมด', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
         ),

         ListTile(
           leading: Icon(Icons.new_releases),
           title: Text('แจ้งจัดชุด Sale It'),
           subtitle: Text('คู่มือขายผลิตภัณฑ์และบริการ'),
           onTap: () {},
         ),
         ListTile(
           leading: Icon(Icons.new_releases),
           title: Text('นำทาง รพ.ผจก กำหนดส่วนงานฝ่ายทรัพยากร'),
           subtitle: Text('Map นำทาง รพ.ผจก กำหนด'),
           onTap: () {},
         ),
         ListTile(
           leading: Icon(Icons.new_releases),
           title: Text('ทดสอบหัวข้อข่าวที่ 3'),
           subtitle: Text('รายละเอียดในหัวข้อข่าวที่ 3'),
           onTap: () {},
         ),
         ListTile(
           leading: Icon(Icons.new_releases),
           title: Text('ทดสอบหัวข้อข่าวที่ 4'),
           subtitle: Text('รายละเอียดในหัวข้อข่าวที่ 4'),
           onTap: () {},
         ),
         ListTile(
           leading: Icon(Icons.new_releases),
           title: Text('ทดสอบหัวข้อข่าวที่ 5'),
           subtitle: Text('รายละเอียดในหัวข้อข่าวที่ 5'),
           onTap: () {},
         )
         
        ]
       ),
    );
  }
}