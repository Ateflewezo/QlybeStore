import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:waitbazz/Screens/ItemListPage.dart';
import 'package:waitbazz/Screens/Homepage.dart';
import 'dart:convert';

class SearchPage extends StatefulWidget {

  final List data;

  const SearchPage(this.data);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

List data = [] ;
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
              searchBar(value).then((comingData){
                  setState(() {
                    data = comingData;
                  });
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


@override
void initState() { 
  super.initState();
  setState(() {
   data = widget.data; 
  });
}
  @override

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
                  ListTile(
                    title: Text("من نحن"),
                    leading: Icon(Icons.question_answer),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  ListTile(
                    title: Text("اتصل بنا"),
                    leading: Icon(Icons.settings_phone),
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
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "البحث ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
      data==null? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,

              ),
            ): data.length > 0 ? ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ItemListPage(data[index]["name"],"${data[index]["id"]}")),
                      );
                    },
                    child: _itemList(
                      data[index]["title"]["rendered"],
                      data[index]["acf"]["shopLogo"],
                    )
                );
              },
            ) : Center( child: Text("لا توجد نتائج"), ),
        SizedBox(),
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
                  "",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
