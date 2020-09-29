import 'package:baacstaff/screens/bottomnav/benefit/benefit_screen.dart';
import 'package:baacstaff/screens/bottomnav/checkin/checkin_screen.dart';
import 'package:baacstaff/screens/bottomnav/employee/employee_screen.dart';
import 'package:baacstaff/screens/bottomnav/fundloan/fundloan_screen.dart';
import 'package:baacstaff/screens/bottomnav/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // เรียกใช้ตัวแปร SharedPrefference
  SharedPreferences sharedPreferences;

  // สร้างตัวแปรไว้รับข้อมูลจาก SharedPreferences
  String fullnameAccount, empIDAccount;

  // สร้างฟังก์ชันไว้ดึงข้อมูลตัวแปรแบบ sharedPreferences
  readEmployee() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      empIDAccount = sharedPreferences.getString('storeEmpID');
      fullnameAccount = sharedPreferences.getString('storePrename') + 
                      sharedPreferences.getString('storeFirstname') + " " +
                      sharedPreferences.getString('storeLastname');
    });
  }

  // ฟังก์ชันออกจากระบบ
  signOut() async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('storeStep', 4);
    Navigator.pushReplacementNamed(context, '/lockscreen');
  }

  // สถานะเมื่อหน้าจอโดนโหลดมาครั้งแรก
  @override
  void initState() { 
    super.initState();
    readEmployee();
    _actionWidget = _homeActionBar();
  }

  // สร้างตัวแบบ list เก็บรายการหน้าของ tab bottom
  int _currentIndex = 0;
  String _title = 'หน้าหลัก';
  Widget _actionWidget;

  final List<Widget> _children = [
    HomeScreen(),
    BenefitScreen(),
    FundLoanScreen(),
    CheckinScreen(),
    EmployeeScreen()
  ];

  // สร้าง Widget action สำหรับไว้แยกแสดงผลบน Appbar
  Widget _homeActionBar(){
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/scan');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Row(
          children: [
            Icon(Icons.photo_camera),
            Text(' SCAN')
          ],
        ),
      ),
    );
  }

  Widget _checkInActionBar(){
    return RaisedButton(
      onPressed: (){},
      child: Text(
        'ลงเวลาทำงาน', 
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.red,
    );
  }

  // เขียนเงื่อนไขสลับการเปลี่ยน tab
  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _title = 'หน้าหลัก';
          _actionWidget = _homeActionBar();
          break;
        case 1:
          _title = 'สวัสดิการ';
          _actionWidget = Container();
          break;
        case 2:
          _title = 'กองทุนกู้ยืมเพื่อ...';
          _actionWidget = Container();
          break;
        case 3:
          _title = 'ลงเวลาทำงาน';
          _actionWidget = _checkInActionBar();
          break;
        case 4:
          _title = 'ข้อมูลของฉัน';
          _actionWidget = Container();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('$_title'),
        actions: [
          _actionWidget
        ],
      ),
      // ส่วนของเมนูด้านข้าง
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: GestureDetector(
                  onTap: () { },
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpg')
                  ),
                ),
                accountName: Text('$fullnameAccount'), 
                accountEmail: Text('$empIDAccount'),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/sidecover.jpg'),
                    fit: BoxFit.fill
                  )
                ),
              ),
              ListTile(
                leading: Icon(Icons.new_releases),
                title: Text('ข้อมูลข่าวสาร ธกส.'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/baacnews');
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('ข้อมูลพนักงาน '),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.branding_watermark),
                title: Text('สวัสดิการ'),
                onTap: (){ 
                  Navigator.pop(context);
                },
              ),
               ListTile(
                leading: Icon(Icons.data_usage),
                title: Text('กองทุนกู้ยืมเพื่อสวัสดิการ'),
                onTap: (){ 
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.pin_drop),
                title: Text('พื้นที่ให้บริการ'),
                onTap: (){ 
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/servicemap');
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('ถ่ายภาพและอัพโหลด'),
                onTap: (){ 
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/camera_and_upload');
                },
              ),
              ListTile(
                leading: Icon(Icons.timelapse),
                title: Text('ดูข้อมูลประวัติการลงเวลา'),
                onTap: (){ 
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/showtimedetail');
                },
              ),
              Divider(color: Colors.green[200],),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('ออกจากระบบ'),
                onTap: (){
                  signOut();
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('ยกเลิกการลงทะเบียน'),
                onTap: (){ 
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/cancelaccount');
                },
              ),
            ],
          ),

        )
      ),
      // ส่วนเนื้อหา
      body: _children[_currentIndex],
      // ส่วนเมนูด้านล่าง (tabmenu)
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            title: Text('หน้าหลัก', style: TextStyle(fontSize: 16))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.enhanced_encryption), 
            title: Text('สวัสดิการ', style: TextStyle(fontSize: 16))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance), 
            title: Text('กองทุน', style: TextStyle(fontSize: 16))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time), 
            title: Text('ลงเวลา', style: TextStyle(fontSize: 16))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), 
            title: Text('ฉัน', style: TextStyle(fontSize: 16))
          ),
        ]
      ),
    );
  }

}