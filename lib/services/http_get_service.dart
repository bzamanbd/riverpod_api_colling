import 'dart:convert' as convrt;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_api_colling/models/post.dart';

class HttpGetService {
  static const _baseUrl = "https://jsonplaceholder.typicode.com";
  static const _endPoint = "/posts";

  Future<List<Post>> getAllPosts() async {
    List<Post> posts = [];
    try {
      Uri url = Uri.parse("$_baseUrl$_endPoint");
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List allPosts = convrt.jsonDecode(response.body);
        for (var e in allPosts) {
          Post post = Post.fromMap(e);
          posts.add(post);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return posts;
  }
}
