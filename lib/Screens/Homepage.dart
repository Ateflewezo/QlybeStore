import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waitbazz/Screens/AboutAs.dart';
import 'package:waitbazz/Screens/CallUs.dart';
import 'package:waitbazz/Screens/Itempage.dart';
import 'package:waitbazz/Screens/ItemListPage.dart';
import 'package:waitbazz/Screens/Searchpage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_swiper/flutter_swiper.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
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
  TextEditingController search = TextEditingController();
  String searchWord ;

 loadSlider() async {
    List dataList;
    http.Response slider = await http.get("http://qalyubstore.com/xapix/wp/v2/sliders").then((data) {
      var userData = json.decode(data.body);
     
       dataList = userData;
    
 
    });
   return(dataList);
  }


  loadCategoryResponse() async {
    var responseData =
        await http.get("http://qalyubstore.com/xapix/wp/v2/sections?per_page=100");
    var obj = json.decode(responseData.body);
    var realdata = obj.where((item) => item['parent'] == 0).toList();
    return realdata;
  }
  loadMenuResponse() async {
    var responseData =
    await http.get("http://qalyubstore.com/xapix/wp/v2/sections?per_page=100");
    var obj = json.decode(responseData.body);
    var realdat = obj.where((item) => item['parent'] == 0).toList();
    return realdat;
  }
  // ------------- search bar ----------------
  searchBar(String value) async {
    var responseData =
    await http.get("http://qalyubstore.com/xapix/wp/v2/dalel?search=$value");
    var obj = json.decode(responseData.body);
    return obj;
   }
  List dataobj;
  List dataob;
  
  List slider;
  // int pageno = 1;
  bool clear = true;

  @override
  void initState() {
    loadCategoryResponse().then((data) {
      setState(() {
        dataobj = data;
      });
    });
    loadMenuResponse().then((data) {
      setState(() {
        dataob = data;
      });
    });
    loadSlider().then((data){
setState(() {

  slider=data;

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
      body:dataobj==null?Center(
        child: CircularProgressIndicator(),
      ): ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _appBar(),
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child:Swiper(
              viewportFraction: 1.0,
              scale: 1.0,
              duration: 100,
              scrollDirection: Axis.horizontal,
              itemCount: slider.length,
          autoplayDisableOnInteraction: true,
              loop: true,
              autoplay: true,
              itemBuilder: (BuildContext context,int index){
                return
                  Stack(
                    children: <Widget>[
                     Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration:BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage("http://qalyubstore.com/wp-content/uploads/${slider[index]["better_featured_image"]["media_details"]["file"]}"),fit: BoxFit.cover
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text("${slider[index]["title"]["rendered"]}",style: TextStyle(color: Colors.black,fontSize: 20),),
                        ),
                      )
                    ],
                  );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 8, left: 8, bottom: 100,top: 10),
            child: dataobj == null
                ?
               Center(
                 child: CircularProgressIndicator(
                   backgroundColor: Colors.green,

                 ),
               )
            :GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: dataobj.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemPage(
                                    dataobj[index]["name"],
                                    "${dataobj[index]["id"]}")),
                          );
                        },
                        child: _item(dataobj[index]["name"],
                             dataobj[index]["acf"]["categoryimg"]
                             ), 
                      );
                    }),
          ),

    //        clear == true ? Container(
    //         height: 50,
    //         child: FlatButton(
    //           color: Theme.of(context).accentColor,
    //           onPressed: () async{
    //               setState(() {
    //                pageno += 1; 
    //               });
    // await http.get("http://qalyubstore.com/xapix/wp/v2/sections?page=${pageno}").then((data){
    //   var body = json.decode(data.body);
    //   var realdat = body.where((item) => item['parent'] == 0).toList();
    //   if (body.length > 0) {
    //      setState(() {
    //         dataobj.addAll(realdat);

    //      });
    //   }else {
    //     setState(() {
    //      clear = false; 
    //     });
    //   }
    // });
    //           },
    //           child: Center(child: Text("المزيد" , style: TextStyle(color: Colors.white , fontSize: 18),),),
    //         ),
    //       ) :SizedBox(),
        ],
      ),
    );
  }

  Widget _appBar() {
    return Container(
        height: 40,
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.only(right: 5, left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    _settingModalBottomSheet(context);
                  },
                  child: Icon(Icons.arrow_drop_down, color: Colors.white)),
              Text(
                "كل الاقسام",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ));
  }

  Widget _item(String text, String photo) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: Column(
        children: <Widget>[
          photo==null ?CircularProgressIndicator():  Container(
            height: 135,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(photo), fit: BoxFit.cover),
                color: Colors.red),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            color: Theme.of(context).primaryColor,
            child: Center(
                child: Text(
              text,
              style: TextStyle(color: Colors.white),
            )),
          )
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: dataob.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(dataob[index]["name"]),
                    leading: Icon(Icons.arrow_back_ios),
                  );
                },
              ),
            ),
          );
        });
  }
}
