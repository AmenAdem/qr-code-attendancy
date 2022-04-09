import 'package:flutter/material.dart';
import 'package:testprojet/modules/qrscanner.dart';

class Scan extends StatelessWidget {
  const Scan({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Container(
             padding: EdgeInsets.all(10),
           margin: EdgeInsets.all(10),
           height: 700,
            width: double.infinity,
            alignment: Alignment.center,
            color: Color.fromARGB(255, 253, 253, 253),
                child: Column(
      
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 100,
                      width: 250,
                      decoration: BoxDecoration(
                              color: Color.fromARGB(255, 165, 161, 161),
                              borderRadius:BorderRadius.circular(20)),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Text('Scanner le code pour Confirmer votre présence',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                  ),
                                )),
                    ),
                    Image(image: AssetImage('assets/qr2.PNG')),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      height: 60,
                      decoration: BoxDecoration(
                      color: Color(0xff673ab7),
                      borderRadius:BorderRadius.circular(20)),
                      child: FlatButton(   
                       // color: Colors.blue,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return QrScanner();}));
                                },                          
                                   child: Container(
                                    //  alignment: Alignment.center,
                                    //  margin: EdgeInsets.fromLTRB(120,0,100,0),
                                     child:Row(
                                       mainAxisSize: MainAxisSize.max,
                                       children: <Widget>[
                                         SizedBox(
                                            width: 10,
                                          ),
                                         Text('Scanner',
                                            style:TextStyle(
                                              fontSize: 18,
                                              color:Color.fromARGB(255, 230, 218, 218),
                                            ),
                                         ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                         Icon(Icons.qr_code_scanner,
                                         size: 50,
                                         color: Color.fromARGB(255, 230, 218, 218),),
                                       ],
                                     ),
                                   )),
                    ),
                  ],
                ),
              ),
          ),
    );
    
  }
}