import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Welcome'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome BAAC Staff',
              style: TextStyle(fontSize: 30),
            ),
            Image.asset(
              'assets/images/astaff_logo.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20,),
            RaisedButton(
              onPressed: (){
                Navigator.pushNamed(context, "/register");
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'เริ่มต้นใช้งาน',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}