import 'package:flutter/material.dart';
import 'package:flutter_app1/api/post_api.dart';
import 'package:flutter_app1/screens/home/single_post.dart';
import 'package:flutter_app1/shared_ui/post.dart';
import 'dart:math';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:async';
class whatsnew extends StatefulWidget {
  @override
  _whatsnewState createState() => _whatsnewState();
}

class _whatsnewState extends State<whatsnew> {
  post_api pos=post_api();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
          _drawheader(),
            _createtopstories(),
           _drawcrdup(),
         ],
       ),
    );
  }

  Widget _createtopstories() {
  return Container(
    color: Colors.grey.shade100,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Padding(
             padding: EdgeInsets.only(left: 18,top: 18),
              child: _drawscetiontitle('Top Stories'),
    ),
            Padding(padding: EdgeInsets.all(8),
             child: Card(
              child:FutureBuilder(
                future: pos.fetchAllposts(),
              builder: (context,AsyncSnapshot snapshot){
                  switch(snapshot.connectionState){
                      case   ConnectionState.waiting:
                      return _loading();
                        break;
                      case ConnectionState.active:
                        return _loading();
                        break;
                        case ConnectionState.done:
                          if(snapshot.error!=null){
                           return _error();
                          }
                          else{
                           List<post>posts=snapshot.data;
                            if(snapshot.hasData&&posts.length>=3){
                              post poo=snapshot.data[0];
                              post poo1=snapshot.data[1];
                              post poo2=snapshot.data[2];
                              return  Column(
                                children: [
                                  _drawraw(poo),
                                  _drawdivider(),
                                  _drawraw(poo1),
                                  _drawdivider(),
                                  _drawraw(poo2),
                                    ],
                              );
                             }
                            else{
                                return _nodata();
                              }
                            }
                          break;
                        case ConnectionState.none:
                          return _error();
                          break;
                  }

              },
             ),
             ),
            ),
    ],
    ),

  );
  }
  Widget _drawcrdup(){
    return FutureBuilder(
    future: pos.fetchAllupdates(),
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
              return _drawupdate(snapshot.data[0], snapshot.data[1]);
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
    }
    );
  }
  Widget _drawupdate(post p1,p2){
    return     Padding(
      padding: EdgeInsets.only(left: 18,top: 10),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _drawscetiontitle('Recent Update'),
          _drwcaedupdate(Colors.redAccent,p1),
          _drwcaedupdate(Colors.teal,p2),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
}
  Widget _drawraw(post p) {
    List<String> s=p.userid.split(",");
    if(s[0].length>15){
      s[0]=s[0].substring(0,12);
    }
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
        return single(p);
        }),);
      },
      child:Padding(padding: EdgeInsets.all(12),
       child: Row(
      children: [
        SizedBox(
      child: Image.network(p.fetureimage,fit: BoxFit.cover,),
          width: 114,
          height: 114,
    ),
        Expanded(child:Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 4,),
            Text(p.title,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,),),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s[0],style: TextStyle(fontSize: 12),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.timer),
                  Text(_date(p.datewritten),style: TextStyle(fontSize: 12),),
                ],
              ),
            ],
        ),
          ],
        ),
        ),
        ),
      ],
    ),
    ),);
  }

  Widget _drawdivider() {
    return Container(
      color: Colors.grey.shade100,
      width: double.infinity,
      height: 1,
    );
  }

  Widget _drawscetiontitle(String str) {
    return Text(str,textAlign: TextAlign.start,style: TextStyle(color: Colors.grey.shade700,fontWeight:FontWeight.w600 ,fontSize: 16,),);

  }

 Widget _drwcaedupdate(Color color,post pow) {
   return GestureDetector(
     onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context){
         return single(pow);
       }),);
     },
     child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Padding(padding: EdgeInsets.all(12),
         child :Container(
           width: double.infinity,
           height: MediaQuery.of(context).size.height*0.25,
           decoration: BoxDecoration(
             image: DecorationImage(image: NetworkImage(pow.fetureimage),fit: BoxFit.cover),
           ),
         ),),
       Padding(padding: EdgeInsets.only(left:16,top: 10),
         child:Container(
           padding: EdgeInsets.only(left: 24,right: 24,top: 3,bottom: 3),
           decoration: BoxDecoration(
             color: color,
             borderRadius: BorderRadius.circular(8),
           ),
           child: Text(pow.ttt,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white,),),
         ),
       ),
       Padding(padding: EdgeInsets.only(left: 16,top: 16),
         child: Text(pow.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),),
       ),
       Padding(padding: EdgeInsets.all(16),
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Icon(Icons.timer,color: Colors.grey,size: 20,),
             Text(_date(pow.datewritten),style: TextStyle(fontSize: 12,color: Colors.grey),),
           ],
         ),
       ),
     ],
   ),);
  }
 Widget _drawheader(){
    return  FutureBuilder(
      future: pos.fetchAllposts(),
        builder: (context,AsyncSnapshot snapshot){
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
                Random random=Random();
                int rv=random.nextInt(pod.length);
                post ppp=pod[rv];


                if (snapshot.hasData && pod.length >= 2) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return single(ppp);
                      }),);
                    },
                   child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.25,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(ppp.fetureimage),fit: BoxFit.cover),
                    ),
                    child:Center(
                      child:Padding(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(ppp.title,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.yellowAccent,),),
                            Text(ppp.contant,textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color: Colors.yellowAccent),),
                          ],
                        ),
                      ),
                    ),
                  ),);
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
        }
    );
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
}
