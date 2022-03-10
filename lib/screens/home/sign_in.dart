import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/home/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
class sign_in extends StatefulWidget {
  @override
  _sign_inState createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  final _keyform2=GlobalKey<FormState>();
  bool isloading=false;
  bool unvis=true;
  late String username;
  late String password;
  late TextEditingController _username=TextEditingController();
  late TextEditingController _password=TextEditingController();
  late TextEditingController _password2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SIGN IN",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w600),),
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
      key: _keyform2,
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
          _drawlabel("New PassWord", "please enter your password",_password),
          SizedBox(height: 40,),
          _drawlabel("Comfirm PassWord", "please enter the same password",_password2),
          SizedBox(height: 40,),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(onPressed: (){
              if(_keyform2.currentState!.validate()){
              setState((){
              isloading=true;
              });
              username=_username.text;
              password=_password.text;
              data_login();
              Navigator.push(context, MaterialPageRoute(builder:(context){
              return login();
              }));
              }
              else{
              setState((){
              isloading=false;
              });

              }
            }, child: Text("SIGN IN",style: TextStyle(fontSize: 20,),),textColor: Colors.red.shade800,),),
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
    prefs.setString("username", username);
    prefs.setString("password", password);
  }
}
