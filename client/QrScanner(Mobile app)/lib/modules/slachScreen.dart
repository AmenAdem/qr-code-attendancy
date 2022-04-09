import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testprojet/modules/home.dart';
import 'package:testprojet/modules/login_page.dart';
class Splach extends StatefulWidget {
  Splach({Key? key}) : super(key: key);

  String? id ; 
  @override
  State<Splach> createState() => _SplachState();
}

class _SplachState extends State<Splach> {
    @override
   
  void initState(){
    getvalidationdata().whenComplete(() async{
       Timer(Duration(seconds: 1),()=>Get.to(id==null?LoginPage():Home()) );
      
    });
    super.initState();
  }
     Future getvalidationdata()async{
    final SharedPreferences share =await SharedPreferences.getInstance();
    var obtaineid=share.getString('ID');
    setState(() {
      id=obtaineid; 
       
    });
  }
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}