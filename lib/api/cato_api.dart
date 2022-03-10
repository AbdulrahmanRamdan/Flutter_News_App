import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app1/shared_ui/cato.dart';
class catogray_api{
  Future<List<catogray>>fetchAllcato() async {
    List<catogray> catos=[];
    String cato_url="https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=31721deccd9742198ec4bb79babdf356";
    var resp = await http.get( cato_url);
    if(resp.statusCode==200){
      var jasondata=jsonDecode( resp.body );
      var data=jasondata["articles"];
      int i=1;
      for(var item in data){
        var sourse =item['source'];
        catogray cat=catogray(i.toString(), sourse["name"].toString());
        catos.add(cat);
        i++;
      }
    }
    return catos;
  }

}