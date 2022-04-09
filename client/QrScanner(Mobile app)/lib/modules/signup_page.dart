import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testprojet/modules/home.dart';
import 'package:testprojet/modules/login_page.dart';
import 'package:testprojet/modules/qrscanner.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';



class SignupPage extends StatefulWidget{
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {




  var done; 
  final Email=TextEditingController();
  final ID=TextEditingController(); 
  final Pass = TextEditingController();

  signin()async{
     try{
    // print(Email.text);
     //print(Pass.text);

 // var url = Uri.parse('http://192.168.1.104:4000/etudiant/signup');

    //var url = Uri.parse("10.0.2.2:4000/etudiant/signup");
                                                //emulator   // 10.0.2.2
                                                 //local  //192.168.1.104
    //var res=await http.post(Uri.parse('http://192.168.1.104:4000/etudiant/signup'),
     var res=await http.post(Uri(
                                  scheme: 'https',
                                  host:'damp-retreat-05992.herokuapp.com',
                                  path: '/etudiant/signup',),
                                body:{
                                       'email':Email.text,
                                        'password':Pass.text
                                      }
                                   );
    if(res.statusCode==200) {
      print(res.body);
      done=jsonDecode(res.body)["ok"];
      if(done)
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return LoginPage();}));
      } 
    else
    {
      AlertDialog(content: Container(
        child: Text("404"),
      ));
    }
    }
   }catch(e){
     print(e);
   }
   }
  // /*
  // signin()async{
  //   var url = Uri.http('10.0.2.2:4000','/getAllEtudiant');
  //   var res=http.post(url);
  // }
  // */
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
                    SizedBox(height: 50,),
                    Text("Créer un Compte ,",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                    SizedBox(height: 6,),
                    Text("Créer un compte pour commancer",style: TextStyle(fontSize: 20,color: Colors.grey.shade400),),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    TextField(
                      controller: Email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400,fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff673ab7),),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                    ),
                    SizedBox(height: 16,),
                    TextField(
                      controller:ID ,
                      decoration: InputDecoration(
                        labelText: "CIN",
                        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400,fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff673ab7),),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                    ),
                    SizedBox(height: 16,),
                    TextField(
                      controller: Pass,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Mote de Passe",
                        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400,fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff673ab7),),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      height: 50,
                      child: FlatButton(
                        onPressed: ()async{
                        signin();
                        //done==0?CircularProgressIndicator():
                        },
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                  Color(0xff673ab7),
                              //  Color.fromARGB(255, 134, 86, 218),
                               // Color(0xffE5E5FF),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(minHeight: 50,maxWidth: double.infinity),
                            child: Text("S'inscrire",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Vous avez déjà un compte .",style: TextStyle(fontWeight: FontWeight.bold),),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage(),));
                        },
                        child: Text("Se Connecter.",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff673ab7),),),
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




