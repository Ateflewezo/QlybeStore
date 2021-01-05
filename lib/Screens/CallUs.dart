import 'package:flutter/material.dart';
import 'package:waitbazz/Screens/AboutAs.dart';
class CallUs extends StatefulWidget {
  @override
  _CallUsState createState() => _CallUsState();
}

class _CallUsState extends State<CallUs> {
  @override
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
        body: Directionality(
          textDirection: TextDirection.rtl,
                  child: ListView(
            children: <Widget>[
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
              ),
              SizedBox(height: 5,),
           Column(
             children: <Widget>[
               ListTile(
                 title: Text("02000000000000000"),
                 leading: Icon(Icons.settings_phone,color:Theme.of(context).accentColor,),
               ),
               Divider(color: Colors.grey,height: 1,),
               ListTile(
                 title: Text("WaitBazz@gmail.com"),
                 leading: Icon(Icons.email,color:Theme.of(context).accentColor,),
               ),
               Divider(color: Colors.grey,height: 1,),
               ListTile(
                 title: Text("المنصورة"),
                 leading: Icon(Icons.location_city,color:Theme.of(context).accentColor,),
               ),
             ],
           )
            ],
          ),
        ),
      
    );
  }
}