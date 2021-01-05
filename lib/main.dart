import 'package:flutter/material.dart';
import 'package:waitbazz/Splash.dart';
import './Screens/Homepage.dart';
//import './Screens/Itempage.dart';
//import './Screens/ItemListPage.dart';
//import './Screens/AboutAs.dart';
//import './Screens/CallUs.dart';

void main(){
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}
class _MyappState extends State<Myapp> {

  int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

       theme: ThemeData(
        primaryColor: Color(getColorHexFromStr('#E8bc3b')),
        fontFamily: 'cairo',
        accentColor: Color(getColorHexFromStr('#0569d5')),
      ),
      debugShowCheckedModeBanner: false,
     initialRoute: '/',
     routes: {
       '/': (context) => Splash(),
       '/homepage':(context)=>HomePage(),
     },
      
    );
  }
}