// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login1/screen/home.dart';

class WelcomeScreen extends StatelessWidget {
  final data = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('wellcome')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              data.currentUser!.email.toString(),
              style: TextStyle(fontSize: 25),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return HomeScreen();
                  }));
                },
                child: Text("ออกจากระแบบ"))
          ]),
        ),
      ),
    );
  }
}
