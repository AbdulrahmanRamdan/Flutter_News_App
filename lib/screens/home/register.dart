import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/home/login.dart';
import 'package:flutter_app1/utity/Apptheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
class regiter extends StatefulWidget {
  @override
  _regiterState createState() => _regiterState();
}

class _regiterState extends State<regiter> {
  @override
  final _keyform1=GlobalKey<FormState>();
  bool isloading=false;
  bool unvis=true;
  late TextEditingController _username=TextEditingController();
  late TextEditingController _oldusername=TextEditingController();
  late TextEditingController _oldpassword=TextEditingController();
  late TextEditingController _password=TextEditingController();
  late TextEditingController _password2=TextEditingController();
  late String username1;
  late String username2;
  late String password1;
  late String password2;
  @override
  Widget build(BuildContext context) {
    Future<void> setvalue() async {
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      username1=sharedPreferences.getString("username")??" ";
      password1=sharedPreferences.getString("password")??" ";

    }
    return MaterialApp(
      theme:Apptheme.Themed ,
      home:  FutureBuilder(
        future: setvalue(),
        builder: (ctx,snp){
          return snp.connectionState==ConnectionState.waiting?Center(child: CircularProgressIndicator(),):scafold();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
  Widget scafold(){
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTER",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w600),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child:(isloading)?_drawloading():_drawform(),
      ),
    );
  }
  Widget _drawform(){
    return  Form(
      key: _keyform1,
      child:Column(
        children: [
          TextFormField(
          controller: _oldusername,
          decoration: InputDecoration(

            labelText: "Old User name",
            labelStyle: TextStyle(color: Colors.red,fontSize: 16,),
          ),

          validator: (value){
            if(value!.isEmpty){
              return "please enter your old user name";
            }
            return null;
          },
        ),
          SizedBox(height: 40,),
          _drawlabel("Old PassWord", "please enter your old password",_oldpassword),
          SizedBox(height: 40,),
          TextFormField(
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
          _drawlabel("New PassWord", "please enter your New password",_password),
          SizedBox(height: 40,),
          _drawlabel("Comfirm PassWord", "please enter the same password",_password2),
          SizedBox(height: 40,),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(onPressed: (){
              if(_keyform1.currentState!.validate()){
              setState((){
              isloading=true;
              });
              if(_oldpassword.text==password1&& _oldusername.text==username1){
              username2=_username.text;
              password2=_password.text;
              data_login ();
              Navigator.push(context, MaterialPageRoute(builder:(context){
              return login();
              }));
              }
              }
              else{
              setState((){
              isloading=false;
              });

              }
            }, child: Text("REGISTERATION",style: TextStyle(fontSize: 20,),),textColor: Colors.red.shade800,),),
        ],
      ),);
  }
  Widget _drawloading(){
    return Container(

      child:Center(child: CircularProgressIndicator()),
    );
  }
  Widget _drawlabel(String s1,String s2,TextEditingController con){
   return  Row(
      children: [
        SizedBox(
          width: 302,
          child: TextFormField(
            obscureText: unvis,
            controller: con,
            decoration: InputDecoration(
              labelText: s1,
              labelStyle: TextStyle(color: Colors.red,fontSize: 16),
            ),
            validator: (value){
              if(value!.isEmpty||_password.text!=_password2.text){
                return s2;
              }
              return null;
            },
          ),),
        IconButton(onPressed: (){
          if(unvis==true){
            unvis=false;
            setState(() {

            });
          }
          else{unvis=true;
          setState(() {

          });}
        }, icon:Icon( Icons.remove_red_eye),),
      ],);
  }
  void data_login () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username2);
    prefs.setString("password", password2);
  }
}
