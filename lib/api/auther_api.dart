import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app1/shared_ui/auther.dart';

class AuthersApi{

  Future<List<auther>>fetchAllAuthers() async {
    List<auther> Authers=[];
    String allautherapi="https://newsapi.org/v2/everything?q=apple&from=2021-08-05&to=2021-08-05&sortBy=popularity&apiKey=31721deccd9742198ec4bb79babdf356";
    var resp = await http.get( allautherapi);
    if(resp.statusCode==200){
      var jasondata=jsonDecode( resp.body );
      var data=jasondata["articles"];
      for(var item in data){
        var sourse =item['source'];
        auther Auth=auther(sourse['id'].toString(), item['author'].toString(), item['url'].toString(), item['urlToImage'].toString());
        Authers.add(Auth);
      }
    }
    return Authers;
  }

}