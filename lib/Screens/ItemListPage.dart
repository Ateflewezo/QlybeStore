import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:waitbazz/Screens/AboutAs.dart';
import 'package:waitbazz/Screens/CallUs.dart';
import 'package:waitbazz/Screens/Homepage.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:url_launcher/url_launcher.dart'as UrlLauncher;
import 'package:waitbazz/Screens/Itempage.dart';
import 'package:waitbazz/Screens/Searchpage.dart';

class ItemListPage extends StatefulWidget {
  final String name;
  final String id;

  const ItemListPage(this.name, this.id);

  @override
  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {

  
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


  var dataobj;
//  _launchCaller() async {
//    UrlLauncher.launch("tel:${ dataobj["acf"]["phone"]}");
////    const url =  "tel:${dataobj["acf"]["phone"]}";
////    if (await canLaunch(url)) {
////      await launch(url);
////    } else {
////      throw 'Could not launch $url';
////    }
//  }


  loadCategoryResponse() async {
    var responseData =
    await http.get("http://qalyubstore.com/xapix/wp/v2/dalel/${widget.id}");
    var obj = json.decode(responseData.body);
    var realdata = obj;
    return realdata;
  }


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
                  height: 150,
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
      body:  Directionality(
        textDirection: TextDirection.rtl,
        child: dataobj==null?Center(
          child: CircularProgressIndicator(),
        ):Container(
          child: CustomScrollView(
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true, 
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
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
                            Text(
                        "${
                        widget.name}",
                              style: TextStyle(color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              // padding: EdgeInsets.only(right: 20),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: NetworkImage(dataobj["acf"]["shopLogo"]), fit: BoxFit.cover)),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                              dataobj==null?CircularProgressIndicator():  dataobj["title"]["rendered"],
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                              Text(
                                "باطنة وسكر",
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                    height: 100,
                      color: Colors.grey.withOpacity(0.1),
                      child: Padding(
                          padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                          child:Text(dataobj["content"]["rendered"])
                      ),
                    ),
                 Padding(
                   padding: const EdgeInsets.only(right: 10),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.only(top: 5,bottom: 5),
                         child: Row(
                           children: <Widget>[
                             Icon(
                               Icons.settings_phone,
                               color: Colors.grey,
                             ),
                               SizedBox(width: 10,),
                             InkWell(
                               onTap: (){
                                 UrlLauncher.launch("tel:+${ dataobj["acf"]["phone"]}");
                               },

                               child: Text(
                                 dataobj["acf"]["phone"],
                                 style: TextStyle(color: Colors.blueAccent),
                               ),
                             ),
                           ],
                         ),
                       ),
                       Divider(
                         color: Colors.grey,
                         height: 1,
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 5,bottom: 5),
                         child: Row(
                           children: <Widget>[
                             Icon(
                               Icons.location_on, 
                               color: Colors.grey,
                             ),
                             SizedBox(width: 10,),
                             Text(
                               dataobj["acf"]["address"],
                               style: TextStyle(color: Colors.blueAccent),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),

                    Container(
                      height: 40,
                      decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                      child: Center(
                          child: Text(
                            "المنتجات",
                            style: TextStyle(color: Colors.white), 
                          )),
                    ),
                    SizedBox(height: 10,),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 5 ) ,
                  child: (dataobj["acf"]["shopProducts"] != false && dataobj["acf"]["shopProducts"] != true  && (dataobj["acf"]["shopProducts"]).length > 0  )?
                  GridView.builder(
                physics: NeverScrollableScrollPhysics(), 
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.78,
                      ),
                      itemCount: (dataobj["acf"]["shopProducts"] != false && dataobj["acf"]["shopProducts"] != true  && (dataobj["acf"]["shopProducts"]).length > 0  )? (dataobj["acf"]["shopProducts"]).length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return  _test(
                          dataobj["acf"]["shopProducts"][index],
                          
                        );
                      }) :SizedBox(),
                   )
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ));
  }


  Widget _test(products){
            return 
               Container(
                 decoration: BoxDecoration(
                   border: Border.all(width: 1 , color: Colors.blueAccent )
                 ),
                 child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[

                    InkWell(
                      onTap:(){
_showDialog(products["productImg"]);
                      },
                      child: Container(
                            height: 140,
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                       image: DecorationImage(
                           image: NetworkImage(products["productImg"]), fit: BoxFit.cover),
                 ),
             ),
                    ),

             Container(child: Center(child: Text(products["productName"] , style: TextStyle(fontSize: 13),) ) , height: 50,),
             Container(
                 height: 26,
             width: MediaQuery.of(context).size.width,
             color: Colors.blueAccent,
             child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: <Widget>[
             Text("السعر",style: TextStyle(color: Colors.white),),
             Text(products["productPrice"],style: TextStyle(color: Colors.white),),
             Text("جنية",style: TextStyle(color: Colors.white),),
             ],
             ),
             )
                  ],
              
    ),
               );
  }
  void _showDialog(String image) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  
          content:Container(
                            height: 300,
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                       image: DecorationImage(
                           image: NetworkImage(image), fit: BoxFit.fill),
                 ),
             ),
          actions: <Widget>[
           
          
          ],
        );
      },
    );
  }


  }


