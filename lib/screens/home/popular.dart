import 'package:flutter/material.dart';
import 'package:flutter_app1/api/post_api.dart';
import 'package:flutter_app1/screens/home/single_post.dart';
import 'package:flutter_app1/shared_ui/post.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:async';
class popular extends StatefulWidget {
  @override
  _popularState createState() => _popularState();
}

class _popularState extends State<popular> {
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
                  return   ListView.builder(itemBuilder: (context,position){
                    return Card(
                      child: _drawraw(poi[position]) ,
                    );
                  },
                    itemCount: poi.length,
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
  Widget _drawraw(post post) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return single(post);
        }),);
      },
     child: Padding(padding: EdgeInsets.all(12),
      child: Row(
        children: [
          SizedBox(
            child: Image(image: NetworkImage(post.fetureimage),
              fit: BoxFit.cover,
            ),
            width: 124,
            height: 124,
          ),
          Expanded(child:Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 4,),
                Text(post.title,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,),),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(post.userid.substring(0,10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.timer),
                        Text(_date(post.datewritten)),
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
