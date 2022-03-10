import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/pagess/about.dart';
import 'package:flutter_app1/screens/pagess/contant.dart';
import 'package:flutter_app1/screens/pagess/Help.dart';
enum PopOutMenu{HELP,ABOUT,CONTACT}
class popmenu{
 late BuildContext context;
 popmenu(this.context);
 Widget Popoutmenu(BuildContext context) {
   return PopupMenuButton(itemBuilder: (context){
     return [
       PopupMenuItem<PopOutMenu>(child: Text('ABOUT'),value: PopOutMenu.ABOUT,),
       PopupMenuItem<PopOutMenu>(child: Text('CONTACT'),value: PopOutMenu.CONTACT,),
       PopupMenuItem<PopOutMenu>(child: Text('HELP'),value: PopOutMenu.HELP,),
     ] ;
   },onSelected: (PopOutMenu menu){
     switch(menu) {
       case PopOutMenu.ABOUT:
         Navigator.push(context,
             MaterialPageRoute(builder: (context) {
               return about();
             }
             )
         );
         break;
       case PopOutMenu.CONTACT:
         Navigator.push(context,
             MaterialPageRoute(builder: (context) {
               return contact();
             }
             )
         );
         break;
       case PopOutMenu.HELP:
         Navigator.push(context,
             MaterialPageRoute(builder: (context) {
               return help();
             }
             )
         );
         break;
     }
   },);
 }
}