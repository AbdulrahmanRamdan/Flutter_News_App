import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/home/HeadLine_news.dart';
import 'package:flutter_app1/screens/home.dart';
import 'package:flutter_app1/screens/home/login.dart';
import 'package:flutter_app1/screens/home/register.dart';
import 'package:flutter_app1/screens/home/twiter.dart';
import 'package:flutter_app1/screens/home/instegram.dart';
import 'package:flutter_app1/screens/home/facebook_feed.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'nav)dr_items.dart';
bool islogin=true;
late String ss;
late  Widget we;
class drawerr extends StatefulWidget {
  @override
  _drawerrState createState() => _drawerrState();

}

class _drawerrState extends State<drawerr> {
  bool islogin=true;
  late String ss;
  late  Widget we;
  @override
  Widget build(BuildContext context) {
    get_String();
    get_Widget();
    List<nav_dr_item>nav=[
      nav_dr_item('Explore',()=> HOMEE()),
      nav_dr_item('Headline News',()=> heedline_news()),
      nav_dr_item('Twitter Feeds',()=> twiterfeed()),
      nav_dr_item('Instagram Feeds',()=>insta_feed() ),
      nav_dr_item('Facebook Feeds',()=>facebook_feed() ),
      nav_dr_item('Register',()=>regiter() ),
      nav_dr_item(ss,()=>we ),

    ];
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: 75,left: 24,),
      child:ListView.builder(itemBuilder: (context,position){
        return  Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
          title: Text(nav[position].title,style: TextStyle(fontSize: 22,color: Colors.grey.shade700),),
          trailing:Icon(Icons.chevron_right,color: Colors.grey.shade500,) ,
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return nav[position].destinaion();
            },),);
          },
        ),);
      },
        itemCount: nav.length,
      ),
        ),
    );
  }
 void get_String(){
    if(islogin==true ){
     ss="LogOut";
    }
    else{

      ss= "Login";
    }
  }
  void get_Widget(){
      _updatevalue();
      we= login();

  }

  void _updatevalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("checkloginvalue", false);
  }
}
