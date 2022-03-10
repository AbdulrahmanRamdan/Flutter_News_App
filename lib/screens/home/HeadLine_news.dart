import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/home/popular.dart';
import 'package:flutter_app1/shared_ui/drawer.dart';
import 'package:flutter_app1/utity/popmenu.dart';
import 'favourit.dart';
import 'package:url_launcher/url_launcher.dart';
class heedline_news extends StatefulWidget {
  @override
  _heedline_newsState createState() => _heedline_newsState();
}
class _heedline_newsState extends State<heedline_news>  with SingleTickerProviderStateMixin{
  late TabController _TabController;
  @override
  void initState() {
    super.initState();
    _TabController=TabController(initialIndex: 0,length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    popmenu pop_menu=popmenu(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('HeadLine News'),
        centerTitle: false,
        actions: [
          IconButton(onPressed: (){search_url();}, icon: Icon(Icons.search)),
          pop_menu.Popoutmenu(context),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: " WHAT'S NEW ",
            ),
            Tab(
              text: " POPULAR ",
            ),
            Tab(
              text: " FAVOURITES ",
            ),
          ],
          controller: _TabController,
        ),
      ),
      drawer: drawerr(),
      body: Center(
        child: TabBarView(
          children: [
            favourit(),
            popular(),
            favourit(),
          ],
          controller: _TabController,
        ),
      ),

    );
  }

  Future<void> search_url() async {
    if(await canLaunch ("https://www.google.com/?hl=ar") ){
      await launch("https://www.google.com/?hl=ar");
    }
    else{
      print("CANNOT Launch");
    }
  }
}
