import 'package:flutter/material.dart';

class about extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ABOUT US"),
        centerTitle: true,
      ),
      body: Center(
        child:Padding(
          padding: EdgeInsets.all(20),
        child:Container(
        child: Text("The news program is a program that smoothly displays the wells with live and realistic images. You can also interact with them and add your own comment. You can be a member in it or not as you wish. You can also get a clearer and more beautiful explanation as you respond. You only need to click only. Also, you can search for the event you want."
        ,style: TextStyle(color: Colors.teal.shade800,
         fontSize: 25,
        letterSpacing: 1.25,
        wordSpacing: 1.25,
            height: 1.5,
          ),
        ),
        ),
      ),),
    );
  }
}

