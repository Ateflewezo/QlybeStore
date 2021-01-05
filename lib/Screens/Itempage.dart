import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:waitbazz/Screens/AboutAs.dart';
import 'package:waitbazz/Screens/CallUs.dart';
import 'package:waitbazz/Screens/ItemListPage.dart';
import 'dart:convert';

import 'Searchpage.dart';

class ItemPage extends StatefulWidget {
  final String name ;
  final String id ;

  const ItemPage(this.name, this.id) ;
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {


  String _searchText = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Container(
    width: 100,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/logo.png"), fit: BoxFit.cover)),
  );
  TextEditingController _filter = TextEditingController();
  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          onSubmitted: (value){
            if (value.length > 0) {
              searchBar(value).then((data){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage(data) ),
                );
              });
            }
          },
          controller: _filter,
          decoration: new InputDecoration(
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Container(
          width: 100,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/logo.png"), fit: BoxFit.cover)),
        );
        _filter.clear();
      }
    });
  }

    searchBar(String value) async {
    var responseData =
    await http.get("http://qalyubstore.com/xapix/wp/v2/dalel?search=$value");
    var obj = json.decode(responseData.body);
    return obj;
   }

  int pageno = 1;
  bool clear = true;
  List subCat = [];
  String acutalId ;

  loadCategoryResponse() async {
    var responseData =
    await http.get("http://qalyubstore.com/xapix/wp/v2/dalel?sections=${acutalId}");
    var obj = json.decode(responseData.body);
    var realdata = obj;
    return realdata;
  }
  loadsubcategory() async {
    var responseData =
    await http.get("http://qalyubstore.com/xapix/wp/v2/sections?per_page=100");
    var obj = json.decode(responseData.body);
    var realdata = obj.where((item) => item['parent'] == int.parse(acutalId)).toList();
    return realdata;
  }
  loadSubCategoryResponse() async {
    var responseData =
    await http.get("http://qalyubstore.com/xapix/wp/v2/dalel?sections=${acutalId}");
    var obj = json.decode(responseData.body);
    var fakedata = obj;
    return fakedata;
  }
  
  List dataobj;

  @override
  void initState() {
    setState(() {
     acutalId = widget.id; 
    });
    loadCategoryResponse().then((data) {
      setState(() {
        dataobj = data;
      });
    });
    loadsubcategory().then((data) {
      setState(() {
      subCat =data;
    });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: _appBarTitle,
        centerTitle: true,
        leading:  InkWell(
          onTap: (){
            _searchPressed();
          },
          child: _searchIcon,
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
                    onTap: () {
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutAs(),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallUs(),
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
                              )),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/inst.png"),
                              )),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/twit.png"),
                              )),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/yout.png"),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).accentColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/homepage");
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _settingModalBottomSheet(context);
                      },
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "اختار القسم الفرعى  ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            dataobj==null || dataobj== []? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,

              ),
            ): dataobj.length > 0 ?
             ListView.builder(
              itemCount: dataobj.length > 0 ? dataobj.length : 20,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ItemListPage(dataobj[index]["title"]["rendered"],"${dataobj[index]["id"]}")),
                      );
                    },
                    child: _itemList(
                        dataobj[index]["title"]["rendered"],
                      dataobj[index]["acf"]["shopLogo"],
                    )
                );
              },
            ) 
            : 
            Center( child: 
            subCat.length > 0  ?
             Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: MediaQuery.of(context).size.height - 170,
              child: ListView.builder(
                itemCount: subCat != null  ?  subCat.length  :20,
                itemBuilder: (BuildContext context, int indext) {
                  return InkWell(
                    onTap: (){
                      setState(() {
                       acutalId = "${subCat[indext]["id"]}" ;
                         loadCategoryResponse().then((data) {
                              setState(() {
                                dataobj = data;
                              });
                            });
                      });
                    
                    },
                      child: ListTile(
                      title: Text(subCat[indext]["name"]),
                      leading: Container(height : 45 , width:45  ,decoration:BoxDecoration(
                        image:DecorationImage(
                          image :  NetworkImage(subCat[indext]["acf"]["categoryimg"]),
                          fit :BoxFit.fill
                        )
                      ) ) ,
                    ),
                  );
                },
              ),
            ),
          ) : 
          Container(
              height: MediaQuery.of(context).size.height,
              child: Center(child: Text("لا يوجد أقسام فرعية" , style: TextStyle(color: Colors.redAccent , fontSize: 18),),),
            ),
             ),
                  (clear == true && dataobj != null ) ?  dataobj.length > 0 ? Container(
            height: 50,
            child: FlatButton(
              color: Theme.of(context).accentColor,
              onPressed: () async{
                  setState(() {
                   pageno += 1; 
                  });
    await http.get(
      "http://qalyubstore.com/xapix/wp/v2/dalel?sections=${acutalId}&page=${pageno}"
    ).then((data){
      var body = json.decode(data.body);

        if (body["data"]["status"] == 400) {
          setState(() {
            clear =false;
          });
        }else {
         setState(() {
            dataobj.addAll(body); 
         });
        }
    });
              },
              child: Center(child: Text("المزيد" , style: TextStyle(color: Colors.white , fontSize: 18),),),
            ),
          ) : SizedBox() :SizedBox(),
          ],
        ));
  }

  Widget _itemList(String text, String photo) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.2))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                  image: NetworkImage(photo), fit: BoxFit.cover)),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(color: Colors.blueAccent),
                ),
                Text(
                  widget.name,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {

   (subCat != [] &&  subCat != []  && subCat.length > 0)  ? showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: subCat.length >  0 ?  subCat.length  :20,
                itemBuilder: (BuildContext context, int indext) {
                  return InkWell(
                    onTap: (){
                      setState(() {
                       acutalId = "${subCat[indext]["id"]}" ;
                         loadCategoryResponse().then((data) {
      setState(() {
        dataobj = data;
      });
    });
                      });
                      Navigator.pop(context);
                    },
                      child: ListTile(
                      title: Text(subCat[indext]["name"]),
                      leading: Icon(Icons.arrow_back_ios) ,
                    ),
                  );
                },
              ),
            ),
          );
        }) : 
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Center(child: Text("لا يوجد أقسام فرعية" , style: TextStyle(color: Colors.redAccent , fontSize: 18),),),
            ),
          );
        });

  }
}
