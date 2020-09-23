import 'package:baacstaff/models/NewsModel.dart';
import 'package:baacstaff/services/rest_api.dart';
import 'package:baacstaff/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final String _currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final String _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

  // สร้าง Ojbect Geolocator
  Position position;
  String _lat, _lon;
 
  // ฟังก์ชันเช็คว่าผู้ใช้เปิด GPS แล้วหรือยัง
  checkGPS() async {
    bool _isLocationServiceEnabled = await isLocationServiceEnabled();
    if(_isLocationServiceEnabled){
      position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _lat = position.latitude.toString();
      _lon = position.longitude.toString();
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
                Utility.getInstance().showAlertDialog(
                  context, 
                  'เรียบร้อย', 
                  'บันทึกข้อมูลเวลาเข้าทำงานเรียบร้อยแล้ว\nที่พิกัด $_lat,$_lon'
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.time_to_leave),
              title: Text('ลงเวลาออกงาน'),
              onTap: () { 
                Utility.getInstance().showAlertDialog(
                  context, 
                  'เรียบร้อย', 
                  'บันทึกข้อมูลเวลาออกงานเรียบร้อยแล้ว\nที่พิกัด $_lat,$_lon'
                );
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

    }else{
      Utility.getInstance().showAlertDialog(context, 'คุณยังไม่ได้เปิด GPS', 'กรุณาเปิดก่อนใช้งาน');
    }
  }

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
                              checkGPS();
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
           height: MediaQuery.of(context).size.height * 0.28,
           child: FutureBuilder(
             future: CallAPI().getNews(),
             builder: (BuildContext context, AsyncSnapshot<List<NewsModel>> snapshot){
               if(snapshot.hasError){
                 return Center(
                   child: Text('มีข้อผิดพลาด ${snapshot.error.toString()}'),
                 );
               }else if(snapshot.connectionState == ConnectionState.done){
                List<NewsModel> news = snapshot.data;
                return _builderListView(news);
               }else{
                 return Center(
                   child: CircularProgressIndicator(),
                 );
               }
             }
          ),
         ),
         Padding(
           padding: const EdgeInsets.only(top:15.0, left: 15.0, bottom: 15.0),
           child: Text('ข่าวทั้งหมด', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
         ),

         Container(
           height: MediaQuery.of(context).size.height * 0.28,
           child: FutureBuilder(
             future: CallAPI().getNews(),
             builder: (BuildContext context, AsyncSnapshot<List<NewsModel>> snapshot){
                 if(snapshot.hasError){
                   return Center(
                     child: Text('มีข้อผิดพลาด ${snapshot.error.toString()}'),
                   );
                 }else if(snapshot.connectionState == ConnectionState.done){
                  List<NewsModel> news = snapshot.data;
                  return _listViewAllNews(news);
                 }else{
                   return Center(
                     child: CircularProgressIndicator(),
                  );
                }
             }
        ),
         ),

        ]
       ),
    );
  }

  // ListView builder
  Widget _builderListView(List<NewsModel> news){
    return ListView.builder(
           scrollDirection: Axis.horizontal,
           itemCount: news.length, 
           itemBuilder: (context, index) {
           // Load Model
           NewsModel newsModel = news[index];
              return Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: InkWell(
                  onTap: () => url_launcher.launch('https://pub.dev/packages/url_launcher'),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        // Image.network(newsModel.imageurl, height: 50,),
                        image: DecorationImage(
                          image: NetworkImage(newsModel.imageurl, ),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              newsModel.topic, 
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.0, 
                                fontWeight: FontWeight.bold
                              )
                            ),
                            Text(
                              newsModel.detail,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.0, 
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          );
  }


  // ListView All news
  Widget _listViewAllNews(List<NewsModel> news){  
    return ListView.builder(
           scrollDirection: Axis.vertical,
           itemCount: news.length, 
           itemBuilder: (context, index) {
             NewsModel newsModel = news[index];
             return ListTile(
              leading: Icon(Icons.new_releases),
              title: Text(newsModel.topic, overflow: TextOverflow.ellipsis),
              subtitle: Text(newsModel.detail, overflow: TextOverflow.ellipsis),
              onTap: () {
                Utility.getInstance().showAlertDialog(
                  context, newsModel.topic, newsModel.detail
                );
              },
            );
          });
  }


}