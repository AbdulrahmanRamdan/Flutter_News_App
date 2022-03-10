import 'package:flutter/material.dart';
import 'package:flutter_app1/shared_ui/drawer.dart';
import 'package:flutter_app1/api/post_api.dart';
import 'package:flutter_app1/screens/home/single_post.dart';
import 'package:flutter_app1/shared_ui/post.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
class insta_feed extends StatefulWidget {
  @override
  _insta_feedState createState() => _insta_feedState();
}
class _insta_feedState extends State<insta_feed> {
  late List<int>ids;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ids=[0,3,6];
  }
  @override
  post_api post_API=post_api();
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
                      title: Text('Instegram Feeds'),
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
                        return _drawfacecard(position,poi[position]);
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
  Widget _drawfacecard(int po,post poo) {
    return
      Card(
        child: Column(
          children: [
            _cardhead(po,poo),
            _cardbody(poo),
            _cardfooter(poo),
          ],
        ),
      );
  }

  Widget _cardhead(int po,post poo) {
    return Row(
      children: [
        Padding(padding: EdgeInsets.all(16),
          child:CircleAvatar(
            backgroundImage: NetworkImage(poo.fetureimage),
            radius: 24,
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Text(poo.userid.substring(0,10),style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w700,fontSize: 20,)),
              ],
            ),
            SizedBox(height: 8,),
            Text(poo.datewritten,style: TextStyle(color: Colors.grey,fontSize: 14,),),
          ],
        ),
        SizedBox(width: 50,),
        IconButton(onPressed: (){
          if(ids.contains(po)){
            ids.remove(po);
          }
          else{ids.add(po);}
          setState(() {

          });
        },
          icon: Icon(Icons.favorite),
          color:(ids.contains(po))?Colors.red: Colors.grey,),
        Text('25',style: TextStyle(color: Colors.grey,fontSize: 12,),),
      ],
    );
  }


  Widget _cardfooter(post poo) {
    return Padding(padding: EdgeInsets.only(left: 16,right: 5,bottom: 6,),
      child: Row(children: [
        Row(
          children: [
            Text('25',style: TextStyle(color: Colors.deepOrange,),),
            // Text('COMMENTS',style: TextStyle(color: Colors.deepOrange,),),
            FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return single(poo);
              }));
            }, child: Text('COMMENTS',style: TextStyle(color: Colors.deepOrange,),)),
          ],),
        SizedBox(width: 30,),
        Row(
          children: [
            FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return single(poo);
              }));
            }, child: Text('SHARE',style: TextStyle(color: Colors.deepOrange,),)),
            FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return single(poo);
              }));
            }, child: Text('OPEN',style: TextStyle(color: Colors.deepOrange,),)),

          ],
        ),
      ],),
    );
  }

  Widget _cardbody(post poo) {
    return Padding(padding: EdgeInsets.all(16),
      child:Column(
        children: [
          Text(poo.contant,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 18),),
          SizedBox(height: 4,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('#advance',style: TextStyle(color: Colors.deepOrange,fontSize: 14),),
              Text('#retro',style: TextStyle(color: Colors.deepOrange,fontSize: 14),),
              Text('#instagram',style: TextStyle(color: Colors.deepOrange,fontSize: 14),),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image:NetworkImage(poo.fetureimage),),
            ),
            height: 200,
            width: double.infinity,
          )
        ],
      ),);
  }

  String _date(String datewritten) {
    Duration timeAgo=DateTime.now().difference(DateTime.parse(datewritten));
    DateTime def=DateTime.now().subtract(timeAgo);
    return timeago.format(def);
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
