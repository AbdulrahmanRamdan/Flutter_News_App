import 'package:flutter/material.dart';
import 'package:flutter_app1/api/post_api.dart';
import 'package:flutter_app1/screens/home/single_post.dart';
import 'package:flutter_app1/shared_ui/post.dart';
import 'package:timeago/timeago.dart' as timeago;

class favourit extends StatefulWidget {
  @override
  _favouritState createState() => _favouritState();
}
List <Color> colors=[
  Colors.blue,
  Colors.green,
  Colors.teal,
  Colors.blueAccent,
  Colors.redAccent,
  Colors.orange,
  Colors.cyan,
  Colors.deepOrangeAccent,
  Colors.pink,
];
int colo=0;
Color getcolor(){
  int i;
  i=colo;
  colo++;
  if(colo>=colors.length){
    colo=0;
  }
  return colors[i];

}

class _favouritState extends State<favourit> {
  post_api post_API=post_api();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: post_API.fetchpopular(),
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
      return ListView.builder(itemBuilder: (context,position){
      return Card(
        child:Padding(
          padding: EdgeInsets.all(16),
        child:Column(
        children: [
          _titlerow(getcolor(),poi[position]),
          SizedBox(height: 16,),
          _itemrow(poi[position]),
        ],
      ),),);

    },
    itemCount: poi.length,);
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

 Widget _titlerow( Color color,post po) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(po.fetureimage),fit: BoxFit.cover),
                ),

                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: 16),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(po.userid,style: TextStyle(color: Colors.grey,),),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_date(po.datewritten),style: TextStyle(color: Colors.grey,),),
                      SizedBox(
                        width: 4,
                      ),
                      Text(po.title.substring(0,15),style: TextStyle(color: color,),) ,
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 5,),
          IconButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context){
             return single(po);
           }));
          }, icon: Icon(Icons.bookmark_border),color: Colors.grey,),
        ],
    );
  }

  Widget _itemrow(post po) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(po.fetureimage),fit: BoxFit.cover)
          ),
          width: 124,
          height: 124,
          margin: EdgeInsets.only(right: 16),
        ),
       Expanded(child:Column(
         children: [
           Text(po.contant,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
           SizedBox(height: 4,),
           Text(po.ttt,style: TextStyle(color: Colors.grey,height: 1.25,fontSize: 14,),),
         ],
       ),
       ),
      ],
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
