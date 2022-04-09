import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:testprojet/modules/home.dart';
import 'package:testprojet/modules/signup_page.dart';
import 'package:testprojet/modules/slachScreen.dart';
import 'modules/login_page.dart';
import 'modules/qrscanner.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home:Home(),//LoginPage(),//Home(),//
    // debugShowCheckedModeBanner: false,
    );
  }
}

