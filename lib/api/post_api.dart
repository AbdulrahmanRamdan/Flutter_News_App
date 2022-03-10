import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app1/shared_ui/post.dart';
class post_api{
  Future<List<post>>fetchAllposts() async {
    List<post> posts=[];
    String post_url="https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=31721deccd9742198ec4bb79babdf356";
    var resp = await http.get( post_url);
    if(resp.statusCode==200){
      var jasondata=jsonDecode( resp.body );
      var data=jasondata["articles"];
      int i=1;
      for(var item in data){
        var sourse =item['source'];
        post pos=post(sourse["id"].toString(),item["title"].toString(),item["content"].toString(),item["publishedAt"].toString(),item["urlToImage"].toString(),'6','33',"","",item["author"].toString(),i.toString(),sourse["name"]);
        posts.add(pos);
        if(i>21){
          i=1;
        }
        else{i++;}
      }
    }
    return posts;
  }

  Future<List<post>>fetchAllupdates() async {
    List<post> posts=[];
    String post_url="https://newsapi.org/v2/everything?domains=wsj.com&apiKey=31721deccd9742198ec4bb79babdf356";
    var resp = await http.get( post_url);
    if(resp.statusCode==200){
      var jasondata=jsonDecode( resp.body );
      var data=jasondata["articles"];
      int i=1;
      for(var item in data){
        var sourse =item['source'];
        post pos=post(sourse["id"].toString(),item["title"].toString(),item["content"].toString(),item["publishedAt"].toString(),item["urlToImage"].toString(),'6','33',"","",item["author"].toString(),i.toString(),sourse["name"]);
        posts.add(pos);
        if(i>21){
          i=1;
        }
        else{i++;}
      }
    }
    return posts;
  }

  Future<List<post>>fetchpopular() async {
    List<post> posts=[];
    String post_url="https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=31721deccd9742198ec4bb79babdf356";
    var resp = await http.get( post_url);
    if(resp.statusCode==200){
      var jasondata=jsonDecode( resp.body );
      var data=jasondata["articles"];
      int i=1;
      for(var item in data){
        var sourse =item['source'];
        post pos=post(sourse["id"].toString(),item["title"].toString(),item["content"].toString(),item["publishedAt"].toString(),item["urlToImage"].toString(),'6','33',"","",item["author"].toString(),i.toString(),sourse["name"]);
        posts.add(pos);
        if(i>21){
          i=1;
        }
        else{i++;}
      }
    }
    return posts;
  }

}