import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:testprojet/modules/user.dart';


 
showAlertDialog(BuildContext context) {  
  // Create button  
  Widget okButton = FlatButton(  
    child: Text("OK"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    title: Text("LICENSE"),  
    content: Text("Qr Scanner Created BY \n Amen Allah Adem \n From BinaryBraines  ^^"),  
    actions: [  
      okButton,  
    ],  
  );  
  // show the dialog  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  
}  

String? id   ; 
User usr = User();
bool loading= true;
class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
Future getvalidationdata()async{
    final SharedPreferences share =await SharedPreferences.getInstance();
    var obtaineid=share.getString('ID');
    setState(() {
      id=obtaineid; 
      getuserdata();
    });
  }
getuserdata()async{
                         //emulator   // 10.0.2.2
                         //local  //192.168.1.104
//var url = Uri.http('10.0.2.2:4000','/etudiant');
final queryParameters = {
        'cin':'${id}',
};
         //var res =await http.get(Uri.http('https://damp-retreat-05992.herokuapp.com','/etudiant',queryParameters),);
        var res =await http.get(Uri(
          scheme: 'https',
          host:'damp-retreat-05992.herokuapp.com',
          path: '/etudiant',
          queryParameters: queryParameters),
          );
  if(res.statusCode == 200){
    var jsonobj =json.decode(res.body);
   // print(jsonobj);
   User.fromJson(jsonobj);
     
          setState(() {
             usr.cIN=jsonobj["cin"];
             usr.eMAIL=jsonobj["email"];
             usr.nOM=jsonobj["nom"];
             usr.pRENOM=jsonobj["prenom"];
             usr.fILIERE=jsonobj["filiere"];
             usr.tD=jsonobj["td"];
             usr.tP=jsonobj["tp"];
             loading=false;
             });
    }
}
 @override
  void initState(){
    getvalidationdata();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
   
    return Container(

      child: loading==true? CircularProgressIndicator(): ListView(children: <Widget>[
        /*  //TODO BADELHA FALSE   */
         prof(),
         myimg(context),

      ]
      ),
    );
  }
}
Widget prof()
{
  return 
     Column(
      children: <Widget>[
        Center(
          child:Padding(
    padding: const EdgeInsets.all(40),
          child: CircleAvatar(
            child: Icon(
              Icons.person,
              size: 50,
            ),

            radius: 50,
          ),
          ),
        ),
          SizedBox(
            width: 40,
          ),
          Column(  
          children:<Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(70, 10,0, 10),
             alignment:Alignment.centerLeft ,
            child: Text('Nom : ${usr.nOM}',
             style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18
                ),
                ),
          ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.fromLTRB(70, 10,0, 10),
                 alignment:Alignment.centerLeft ,
                 child: Align(
                  alignment: Alignment.centerLeft,
                child: Text('Prenom : ${usr.pRENOM}',
           style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18
                ),
                ),
                 ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.fromLTRB(70, 10,0, 10),
                alignment:Alignment.centerLeft ,
                child: Align(
                  alignment: Alignment.centerLeft,
                child: Text('FILIERE : ${usr.fILIERE}',
           style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18
                ),
                ),
                ),
              ),
                  SizedBox(height: 10),
              Container(
                padding: EdgeInsets.fromLTRB(70, 10,0, 10),
                alignment:Alignment.centerLeft ,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('TD: ${usr.tD}',
                   style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                  ),
                  ),
                ),
                ),
                  SizedBox(height: 10),
              Container(
                padding: EdgeInsets.fromLTRB(70, 10,0, 10),
                alignment:Alignment.centerLeft ,
                child: Align(
                  alignment: Alignment.centerLeft,
                child: Text('TP : ${usr.tP}',
           style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18
                ),
                ),
                ),
              ),
        ],
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
}



Widget myimg(context)
{
return Container(
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
               // color: Colors.amber,
                child: Image.asset("assets/isimm.png"),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 100,
                height: 100, 
                //color:Colors.blue,
                child:  Image.asset("assets/univ2.png"),
              ),
                            SizedBox(
                width: 10,
              ),
              Container(
                width: 100,
                height: 100,
                child: InkWell(
                  onDoubleTap: (){
                             showAlertDialog(context);  
                         },
                       splashColor: Colors.purple.withOpacity(0.5),
                         child: Ink(
                               height: 100,
                          width: 100,
                            decoration: BoxDecoration(
                                     image: DecorationImage(
                             image: AssetImage('assets/bb.png'),
                            fit: BoxFit.cover,
                              ),
                            ),
                         ),
) //Image.asset("assets/bb.png"),
               // color:Colors.green
              ),
            ],
          ),
        );
}