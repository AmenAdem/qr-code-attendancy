import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testprojet/modules/user.dart';
import 'package:vibration/vibration.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

bool?done;
String? id;
User? usr;




class QrScanner extends StatefulWidget {
  const QrScanner({ Key? key }) : super(key: key);
  @override
  _QrScannerState createState() => _QrScannerState();
}
class _QrScannerState extends State<QrScanner> {
@override
void initState() {
  //getvalidationdata();
  //getuserdata();
  super.initState();
  
}

  final qrKey = GlobalKey(debugLabel: 'QR');
   Barcode? barcode ;
  QRViewController? controller;


   Future getvalidationdata()async{
    final SharedPreferences share =await SharedPreferences.getInstance();
    var obtaineid=share.getString('ID');
    setState(() {
      id=obtaineid; 
    });
  }




  present()async{
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
                            path: '/etudiant/register-presence',),
                             body:{
                                  'cin':id,
                                  'code':'${barcode?.code}'
                                      }
                                );
    if(res.statusCode==200) {
      print(res.body);
       done=jsonDecode(res.body)["ok"];
       if(done!=null){
         
       }

    }
   }catch(e){
     print(e);
   }
   }

  @override
  Widget build(BuildContext context) {
    void onQRViewCreated(QRViewController controller){
      setState(() {
        this.controller = controller;
      });
      controller.scannedDataStream.listen((
        barcode)async{
          setState(()
          {this.barcode=barcode;}
          
          );
          return;
          }
          );
    }
        Icon a=Icon(Icons.close, color: Colors.white, size: 50);
      Color  c=Colors.red; 
       String t1="Erreur";
      String  t2="Un erreur ce produit";


     a=Icon(Icons.check, color: Colors.white, size: 50);
        c=Colors.green;
        t1="présent(e)";
        t2="Vous etes marker comme present";


    bool verif()
    {
      print('\n\n\n\n${barcode?.code}\n\n\n\n');
      if (barcode?.code!='test')
      {
       // signin();
      return false;
      }
    else
    return true;
    } 
    void set_icon()
    {
      if(verif())
      {
        a=Icon(Icons.check, color: Colors.white, size: 50);
        c=Colors.green;
        t1="présent(e)";
        t2="Vous etes marker comme present";
      }
    }
      @override
      void dispose(){
        controller?.dispose();
        super.dispose();
      }  
      @override
      void reassemble()async{
        super.reassemble();
        if(Platform.isAndroid){
          await controller!.pauseCamera();
        }
        controller!.resumeCamera();
      }
      Widget buildresult()=>
      Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  Text('$t1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(height: 5,),
                  Text('${t2}', style: TextStyle(fontSize: 20),),
                  SizedBox(height: 20,),
                  RaisedButton(onPressed: () {
                    Navigator.of(context).pop();
                  },
                    color: c,
                    child: Text('Okay', style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: c,
              radius: 60,
              child: a,
            )
          ),
        ],
      )
    );
      if(barcode !=null)
      {
          getvalidationdata();
          present();
         // sleep(Duration(seconds:1));
          print('\n\n\n${barcode?.code} ${id} ${usr?.eMAIL} ${usr?.pASSWORD}\n\n\n');
      //  Vibration.vibrate(duration: 50);
        set_icon();
        }

      @override
     Widget buidQrview(BuildContext context)=> QRView(
            overlay: QrScannerOverlayShape(
              cutOutSize: MediaQuery.of(context).size.width*0.8,
              borderColor: Colors.blue,
              borderRadius: 20,
              borderWidth: 10,
            ),
            key: qrKey,
            onQRViewCreated: onQRViewCreated);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buidQrview(context),
            Positioned(bottom: 20, child: barcode==null?Text(barcode!=null?'${barcode?.code}':'data'):buildresult()),
          ],
        ),
      ),
    );
  }
}

