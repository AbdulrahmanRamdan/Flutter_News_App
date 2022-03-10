import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/home/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}
int crunntindex=0;

class _OnboardingState extends State<Onboarding> {
  List<PageStyle>Pageees=[
    PageStyle(Icons.ac_unit,'assets/images/bg.png','WELCOME',"1-Make Friends is easy as waving your hand back and forth is easy step."),
    PageStyle(Icons.pages,'assets/images/bg2.png','BROWSING',"2-It increases your knowledge and experience and gives you a new view of things."),
    PageStyle(Icons.print,'assets/images/bg3.png','PRINT',"3-Try as much as possible to make a copy of what you read in your mind."),
    PageStyle(Icons.alarm_add,'assets/images/bg4.png','ALRAM',"4-Pay attention to what you read, even if it is small, to learn to pay attention between the lines, it will benefit you in your life.")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              itemBuilder: ( context , index) {
                 return Stack(
                   children: [
                     Container(
                       decoration: BoxDecoration(
                         image: DecorationImage(image:ExactAssetImage(Pageees[index].images),fit: BoxFit.cover, ),
                       ),
                     ),
                     Align(
                       alignment: Alignment.bottomCenter,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                           Transform.translate(
                            child: Icon(Pageees[index].ic,size: 150,color: Colors.white,),
                            offset: Offset(0,-100),
                           ),
                           Text(Pageees[index].text1,style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.bold,),textAlign: TextAlign.center, ),
                           Padding(padding: EdgeInsets.only(left: 45,right: 45,top: 35),
                              child: Text(Pageees[index].text2,style: TextStyle(color: Colors.amberAccent,fontSize: 18,),textAlign: TextAlign.center,),
                     ),
                       ],
                     ),
                     ),
                   ],

                 );
              },
            itemCount: 4,
            onPageChanged: (index){
                setState(() {
                  crunntindex=index;
                });
            },

          ),
          Transform.translate(offset: Offset(0,200),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: drawchidrenp(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 25,left: 16,right: 16),
              child:SizedBox(
                width: 350,
                height: 50,
              child: RaisedButton(
                color: Colors.red.shade900,
                  child: Text("GET STARTED",style: TextStyle(color: Colors.white, fontSize: 15,letterSpacing: 1,fontWeight: FontWeight.bold),),
                  onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                   _seeen();
                     return login();
                  },

                  ),
                  );
                  },
              ),
              ),
            ),
          ),
        ],
      ),
    );

  }

  List<Widget> drawchidrenp(){
    List<Widget> llist = <Widget>[];
    for(int i=0;i<Pageees.length;i++){
      if(i==crunntindex){
      llist.add(drawpoint(Colors.white,16));}
      else{llist.add(drawpoint(Colors.redAccent,13));}
    }
    return llist;
  }
  Widget drawpoint(Color color,double wid){
    return Container(
      width: wid,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  void _seeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("seen", true);
  }

}
class PageStyle {
  late IconData ic;
  late String images;
  late String text1;
  late String text2;

  PageStyle(IconData ic,String images,String txt,String txxt){
    this.ic=ic;
    this.images=images;
    this.text1=txt;
    this.text2=txxt;
  }
}

