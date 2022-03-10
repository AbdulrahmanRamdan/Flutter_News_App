import 'package:flutter/material.dart';
import 'package:flutter_app1/api/post_api.dart';
import 'package:flutter_app1/shared_ui/post.dart';
import 'package:timeago/timeago.dart' as timeago;
class single extends StatefulWidget {
  final post postr;
 single(this.postr);
  @override
  _singleState createState() => _singleState();
}

class _singleState extends State<single> {
  post_api pos=post_api();
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(8),
      child: Scaffold(
      body:CustomScrollView(
    slivers: [
      SliverAppBar(
    expandedHeight: 220,
      floating: true,
      pinned: true,
      backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.postr.fetureimage),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
    ),
      SliverList(
        delegate: SliverChildBuilderDelegate((context ,position){
          if(position==0){
          return _drowpostdetails();}
          else if(position>=1&&position<11){
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
                       if (snapshot.hasData ) {
                         return _comments(pod[position]);
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
          else {
           return _textentry();
          }
        },
          childCount: 12,),
      ),
    ],
    ),),

    );

  }

  Widget _drowpostdetails() {
    return Container(
      padding: EdgeInsets.all(8),
    child: Text(widget.postr.contant,style: TextStyle(
      fontSize: 18,
      letterSpacing: 1.2,
      height: 1.2,
    ),),
    );
  }
  String _date(String datewritten) {
    Duration timeAgo=DateTime.now().difference(DateTime.parse(datewritten));
    DateTime def=DateTime.now().subtract(timeAgo);
    return timeago.format(def);
  }
  Widget _comments(post opo) {
    List<String> s=opo.userid.split(",");
    return Padding(padding: EdgeInsets.only(top: 16,left: 16,right: 16),
      child: Column (
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:NetworkImage(opo.fetureimage),
                ),
                SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s[0]),
                    Text(_date(opo.datewritten)),
                  ],
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(8),child:Text(opo.title),),
          ],
      ),
    );
  }

  Widget _textentry() {
    return Padding(
      padding: EdgeInsets.all(16),
      child:Row(
      children: [
        Flexible(child:TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Write Comment Here",
            fillColor: Colors.grey.shade100,
            filled: true,
            contentPadding: EdgeInsets.only(left: 16,right: 16,top: 24,bottom: 24),
          ),
        ),),
        FlatButton(onPressed: (){}, child: Text("SEND",style: TextStyle(color: Colors.red,),),),
       SizedBox(height: 60,),
      ],
    ),);
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
