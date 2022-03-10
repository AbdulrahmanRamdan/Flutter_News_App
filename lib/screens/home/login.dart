import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/home.dart';
import 'package:flutter_app1/screens/home/sign_in.dart';
import 'package:flutter_app1/utity/Apptheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}
late String username;
late String password;
bool checkboxvalue=false;
late bool checkvalue;
late Widget myapp;
class _loginState extends State<login> {
  final _keyform=GlobalKey<FormState>();
  bool isloading=false;
  bool unvis=true;
  IconData hidepasasword=Icons.remove_red_eye;
  late TextEditingController _username=TextEditingController();
  late TextEditingController _password=TextEditingController();
  DateTime f1=DateTime.now();
  @override
  Widget build(BuildContext context) {
    Future<void> setvalue() async {
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      checkvalue=sharedPreferences.getBool("checkloginvalue")??false;
      username=sharedPreferences.getString("username")??" ";
      password=sharedPreferences.getString("password")??" ";
      if(checkvalue==false) {
        if(username==" "&& password==" "){
          myapp=sign_in();
        }
        else{
        myapp= _login();}
      }
      else{myapp=HOMEE();}
    }
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
  Widget _drawform(){
    return  Form(
      key: _keyform,
      child:Column(
        children: [TextFormField(
            controller: _username,
            decoration: InputDecoration(

              labelText: "User name",
              labelStyle: TextStyle(color: Colors.red,fontSize: 16,),
            ),

            validator: (value){
              if(value!.isEmpty){
                return "please enter your user name";
              }
              return null;
            },
          ),
          SizedBox(height: 40,),
          Row(
            children: [
            SizedBox(
              width: 302,
              child: TextFormField(
              obscureText: unvis,
              controller: _password,
              decoration: InputDecoration(
                labelText: "PassWord",
                labelStyle: TextStyle(color: Colors.red,fontSize: 16),
              ),
              validator: (value){
                if(value!.isEmpty){
                  return "please enter your password";
                }
                return null;
              },
            ),),
              IconButton(onPressed: (){
                if(unvis==true){
                  unvis=false;
                  hidepasasword=Icons.remove_red_eye_outlined;
                  setState(() {

                  });
                }
                else{unvis=true;
                hidepasasword=Icons.remove_red_eye;
                setState(() {

                });}
              }, icon:Icon( hidepasasword),),
          ],),
          SizedBox(height: 15,),
          Row(
            children: [
              Checkbox(value: checkboxvalue, onChanged: (value){
                setState(() {
                  checkboxvalue=!checkboxvalue;
                });
              },),
              Text("BE LOGINED",style: TextStyle(color: Colors.red.shade800,fontWeight: FontWeight.bold),),
            ],
          ),
          SizedBox(height: 15,),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: Colors.red.shade800,
              onPressed: (){
              if(_keyform.currentState!.validate()){
                setState((){
                  isloading=true;
              });
                if(username==_username.text&&password==_password.text){
                  if(checkboxvalue==true){
                _updatevalue();}
                Navigator.push(context, MaterialPageRoute(builder:(context){
                              return HOMEE();
                          }));
              }
                else{
              Navigator.push(context, MaterialPageRoute(builder:(context){
              return Scaffold(
              body:Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("ERROR LOGIN ",style:TextStyle(color:Colors.red,fontSize :34 ,fontWeight:FontWeight.w400, )),
              SizedBox(height: 10,),
              RaisedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context){
              return login();
              }));
              },child: Text("Try Agian",style: TextStyle(fontSize: 20,),),textColor: Colors.red.shade800,),
              ],
              ),
              ),);
              }));

              }
              }
              else{
              setState((){
              isloading=false;
              });

              }
            }, child: Text("Login",style: TextStyle(fontSize: 20, letterSpacing: 2,),),textColor: Colors.white,),),
          SizedBox(height: 15,),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return sign_in();
                }));
              }, child: Text("SIGN IN",style: TextStyle(fontSize: 20, letterSpacing: 2,),),textColor: Colors.black54,),),
        ],
      ),);
  }
  Widget _drawloading(){
    return Container(
      child:Center(child: CircularProgressIndicator()),
    );
  }
  void _updatevalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("checkloginvalue", true);
  }

  Widget _login() {
    return WillPopScope(
      child:  Scaffold(
      appBar: AppBar(
        title: Text("LOGIN",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w600),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child:(isloading)?_drawloading():_drawform(),),
    ) ,
      onWillPop: () async {
        f1=DateTime.now();
        final diff=DateTime.now().difference(f1);
        final exit=diff>=Duration(seconds: 2);
        if(exit){
          return false;
        }
        else{
          return true;
        }
      },
    );
  }
}
