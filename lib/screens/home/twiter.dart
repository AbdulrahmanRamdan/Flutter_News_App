import 'package:flutter/material.dart';
import 'package:flutter_app1/shared_ui/drawer.dart';
import 'package:flutter_app1/api/post_api.dart';
import 'package:flutter_app1/screens/home/single_post.dart';
import 'package:flutter_app1/shared_ui/post.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class twiterfeed extends StatefulWidget {
  @override
  _twiterfeedState createState() => _twiterfeedState();
}

class _twiterfeedState extends State<twiterfeed> {
  post_api post_API=post_api();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: post_API.fetchAllupdates(),
    builder: (context,AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
    case ConnectionState.waiting:
    return _loading();
    break;
    case ConnectionState.active:
    return _loading();
    break;
    case ConnectionState.done:
    if (snapshot.error != null) {
    return _error();
    }
    else {
    List<post>pod = snapshot.data;
    if (snapshot.hasData && pod.length >= 2) {
    List<post>poi=snapshot.data;
    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter Feeds'),
        centerTitle: false,
        actions: [
          IconButton(onPressed: (){
            search_url();
            }, icon: Icon(Icons.search)),
        ],
      ),
      drawer:drawerr() ,
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemBuilder: (context,position){
        return _drawtwiterCard(poi[position]);
      },
      itemCount: poi.length,),
    );
    }
    else {
      return _nodata();
    }
    }
    break;
      case ConnectionState.none:
        return _error();
        break;
    }
    })
    ;
  }

  Widget _drawtwiterCard(post po) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child:Card(
      child: Column(
        children: [
          _cardhead(po),
          _cardbody(po),
          Container(
            color: Colors.grey,
            height: 1,
            width: double.infinity,
          ),
          _cardfooter(po),
        ],
      ),
    ),);
  }

  Widget _cardhead(post po) {
    return Row(
      children: [
        Padding(padding: EdgeInsets.all(16),
          child:CircleAvatar(
          backgroundImage: NetworkImage(po.fetureimage),
          radius: 24,
        ),
    ),
        Column(
          children: [
            Row(
              children: [
                Text(po.userid.substring(0,10),style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w700,fontSize: 20,)),
                Text('@gmail.com',style: TextStyle(color: Colors.grey,fontSize: 14,)),
              ],
            ),
            SizedBox(height: 8,),
            Text(po.datewritten,style: TextStyle(color: Colors.grey,fontSize: 14,),),
          ],
        ),
      ],
    );
  }
 Widget _cardbody(post po) {
    return Padding(padding: EdgeInsets.only(left: 16,right: 16,bottom: 16,),
      child:Text(po.contant,style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w300,fontSize: 18,height: 1.25,),),);
 }
 Widget _cardfooter(post po) {
    return Padding(padding: EdgeInsets.only(left: 16,right: 5,bottom: 6,),
    child: Row(children: [
    Row(
    children: [
    IconButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return single(po);
      }));
    }, icon: Icon(Icons.repeat),color: Colors.deepOrange,),
     Text('25'),
      ],),
     SizedBox(width: 107,),
     Row(
       children: [
         FlatButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context){
             return single(po);
           }));
         }, child: Text('SHARE',style: TextStyle(color: Colors.deepOrange,),)),
         FlatButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context){
             return single(po);
           }));
         }, child: Text('OPEN',style: TextStyle(color: Colors.deepOrange,),)),

       ],
     ),
    ],),
    );
 }

  Widget _loading() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  Widget _error(){
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text("Check Your Connection",style: TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.w900,),),
      ),
    );
  }
  Widget _nodata(){
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text("NO DATA FOUND",style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.w900,),),
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
