// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login1/screen/home.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
