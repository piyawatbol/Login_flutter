// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login1/screen/login_screen.dart';
import 'package:login1/screen/register.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: Column(
          children: [
            Image.asset(
              "assets/images/logo.png",
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return RegisterScreen();
                    }));
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    'สร้างบัญชีผู้ใช้',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return LoginScreen();
                    }));
                  },
                  icon: Icon(Icons.login),
                  label: Text('เข้าสู่ระบบ', style: TextStyle(fontSize: 20))),
            )
          ],
        ),
      ),
    );
  }
}
