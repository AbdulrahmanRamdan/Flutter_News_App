import 'package:flutter/material.dart';

class contact extends StatefulWidget {
  @override
  _contactState createState() => _contactState();
}

class _contactState extends State<contact> {
  bool isloading=false;
  final _keyform=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w600),),
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
      key: _keyform,
      child:Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Your name",
              labelStyle: TextStyle(color: Colors.red,fontSize: 16,),
            ),
            validator: (value){
              if(value!.isEmpty){
                return "please enter your name";
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Your Email",
              labelStyle: TextStyle(color: Colors.red,fontSize: 16),
            ),
            validator: (value){
              if(value!.isEmpty){
                return "please enter your email";
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Your massege",
              labelStyle: TextStyle(color: Colors.red,fontSize: 16),
            ),
            maxLines: 4,
            validator: (value){
              if(value!.isEmpty){
                return "please enter your massege";
              }
              return null;
            },
          ),
          SizedBox(height: 40,),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(onPressed: (){
              if(_keyform.currentState!.validate()){
              setState((){
              isloading=true;
              });
              }
              else{
              setState((){
              isloading=false;
              });

              }
            }, child: Text("SEND MASSEGE",style: TextStyle(fontSize: 20,),),textColor: Colors.red.shade800,),),
        ],
      ),);
  }
  Widget _drawloading(){
    return Container(

      child:Center(child: CircularProgressIndicator()),
    );
  }
}
