import 'package:ev_project/add_staton.dart';
import 'package:ev_project/login.dart';
import 'package:flutter/material.dart';
import 'package:ev_project/station.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Station App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StationInformationPage(),
    );
  }
}
