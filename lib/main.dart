import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/home/login.dart';
import 'package:flutter_app1/screens/welcomescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app1/utity/Apptheme.dart';


 main() async {
   runApp(news());
}

class news extends StatelessWidget {
  late Widget myapp;
  late bool value;
  Future<void> setvalue() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    value=sharedPreferences.getBool("seen")??false;
    if(value){myapp=login();}
    else{myapp=Onboarding();}
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:Apptheme.Themed ,
      home:  FutureBuilder(
        future: setvalue(),
        builder: (ctx,snp){
          return snp.connectionState==ConnectionState.waiting?Center(child: CircularProgressIndicator(),):myapp;
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
