import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waitbazz/Screens/CallUs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AboutAs extends StatefulWidget {
  @override
  _AboutAsState createState() => _AboutAsState();
}

class _AboutAsState extends State<AboutAs> {
  loadCategoryResponse() async {
    var responseData =
    await http.get("http://qalyubstore.com/xapix/wp/v2/pages/94");
    var obj = json.decode(responseData.body);
    var realdata = obj;
    return realdata;
  }
  var dataobj;

  @override
  void initState() {
    loadCategoryResponse().then((data) {
      setState(() {
        dataobj = data;
      });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
       iconTheme: new IconThemeData(color: Colors.white),
          elevation: 0.0,
          title: Container(
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logo.png"), fit: BoxFit.cover)),
          ),
          centerTitle: true,
          leading: Icon(
            Icons.search,
          ),
        ),
        endDrawer: Drawer(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView(
              
                children: <Widget>[
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/logo.png"),
                    )),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("/homepage");
                    },
                     child: ListTile(
                      title: Text("الاقسام"),
                      leading: Icon(Icons.menu),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  InkWell(
                     onTap: (){
                       Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>AboutAs(),
                              ),
                    );
                    },
                                      child: ListTile(
                      title: Text("من نحن"),
                      leading: Icon(Icons.question_answer),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                
                  InkWell(
                     onTap: (){
                       Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>CallUs(),
                              ),
                    );
                    },
                                      child: ListTile(
                      title: Text("اتصل بنا"),
                      leading: Icon(Icons.settings_phone),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/fac.png"),
                          )
                        ),),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/inst.png"),
                          )
                        ),),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/twit.png"),
                          )
                        ),),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/yout.png"),
                          )
                        ),),
                    
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
       body: ListView(
         children: <Widget>[
           Container(
             padding: EdgeInsets.only(right: 10),
             height: 40,
             width: MediaQuery.of(context).size.width,
             color: Theme.of(context).accentColor,
             child: Text("من نحن ",style: TextStyle(color: Colors.white),textDirection:TextDirection.rtl,),
           ),
           SizedBox(height: 10,),
           Padding(padding: EdgeInsets.only(right: 10,left: 10),
           child: Material(
             elevation: 1,
             child: Container(
               padding: EdgeInsets.only(right: 10,left: 10),
               height: MediaQuery.of(context).size.height,
               color: Colors.grey.withOpacity(0.3),
               child: Center(child:  dataobj != null ? Text(
                 dataobj != null ? dataobj["content"]["rendered"] : "" ,
                 textAlign: TextAlign.start,
                 textDirection: TextDirection.rtl,
               ) :CircularProgressIndicator()),
             ),
           ),
           )
         ],
       ),
    );
  }
}