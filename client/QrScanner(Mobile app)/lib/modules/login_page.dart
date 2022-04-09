
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testprojet/modules/home.dart';
import 'package:testprojet/modules/qrscanner.dart';
import 'package:testprojet/modules/user.dart';
import 'signup_page.dart';
import 'package:http/http.dart'as http;

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ID=TextEditingController(); 
  final Pass = TextEditingController();

  String? id   ; 
  User usr = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 16,right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 100,),
                    Text("Bienvenue,",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                    SizedBox(height: 30,),
                    Text("Connectez-vous !",style: TextStyle(fontSize: 20,color: Colors.grey.shade400),),
                    SizedBox(height: 10,),
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: ID,
                      decoration: InputDecoration(
                        labelText: "CIN",
                        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff673ab7),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "mot de passe",
                        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff673ab7),
                            )
                        ),
                      ),
                      controller: Pass,
                    ),
                    SizedBox(height: 12,),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(child:Text("Mot de passe oublié ?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xff673ab7),),),onPressed: (){}),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: FlatButton(                 //emulator   // 10.0.2.2
                         onPressed: () async {            //local  //192.168.1.104
                               final queryParameters = {
                                                       'cin':'${ID.text}',
                                                      };
                                        //var res =await http.get(Uri.http('https://damp-retreat-05992.herokuapp.com','/etudiant',queryParameters),);
                                  var res =await http.get(Uri(
                                  scheme: 'https',
                                  host:'damp-retreat-05992.herokuapp.com',
                                  path: '/etudiant',
                                  queryParameters: queryParameters),
                                            );
                               print(res.body);
                                  if(res.statusCode == 200 && res.body!=null){
                                    var jsonobj =json.decode(res.body);
                                        if(jsonobj["cin"]==ID.text){
                                         print(jsonobj);
                                          print(jsonobj["password"]);
                                            if(jsonobj["password"]==Pass.text)     
                                            {
                                              print("login with succes");   //TODO badelha b widget 
                                                 final SharedPreferences shared=await SharedPreferences.getInstance();
                                                shared.setString('ID',ID.text);
                                                print(' \n \n \n local :::::: ${shared.getString('ID')}\n \n \n');
                                                 Get.off(Home()); 
                                                   }
                                                   else
                                                   {
                                              print("\nWrong pass\n"); //TODO badelha b widget 
                                            }
                                          }
                                    }
                            else 
                            {
                              print("not found !!");
                            }
                        },
                        padding: EdgeInsets.all(0),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff673ab7),
                                Color.fromARGB(255, 134, 86, 218),
                                Color(0xffE5E5FF),
                              ],
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(maxWidth: double.infinity,minHeight: 50),
                            child: Text("Se connecter ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    SizedBox(height: 30,),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Je suis un nouvel utilisateur.",style: TextStyle(fontWeight: FontWeight.bold),),
                      GestureDetector(
                        onTap: (){
                         
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return SignupPage();
                          }));
                        },
                        child: Text("S'inscrire ",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff673ab7),),),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}
