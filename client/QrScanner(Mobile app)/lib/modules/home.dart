import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:testprojet/modules/Scan.dart';
import 'package:testprojet/modules/profile.dart';
import 'package:testprojet/modules/qrscanner.dart';
import 'package:testprojet/modules/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


String? id   ; 

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  
  void initState(){
    getvalidationdata().whenComplete(() async{
       Timer(Duration(seconds: 1),()=>Get.off(id==null ?LoginPage():Home() ) );
    });
    super.initState();
  }
    int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[

     Scan(),
     Profile(),
     ];
    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
     // print('\n\n\n\n${id}\n\n\n');
    });
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
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff673ab7),
        onTap: _onItemTapped,
      ),
    );
  }
}



