import 'dart:convert';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/api/parsed.dart';
import 'package:news/api/url.dart';

class API_Manager {
  Future<Post?> getNews() async {
    var client = http.Client();
    // var post = null;
    var uri = Uri.parse(
        'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=571a9a40b4434d3590ef09d6ac03b9ba');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;

      return postFromJson(json);
      // var jsonMap = json.decode(jsonString);
      // post = Post.fromJson(jsonMap);
    }
    // return post;
  }
}
