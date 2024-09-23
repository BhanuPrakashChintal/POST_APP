import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'post_model.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  int _page = 1;
  final int _limit = 10;
  bool _hasMore = true;
  bool _isLoading = false;

  List<Post> get posts => _posts;
  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  Future<void> fetchPosts() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    final url =
        'https://jsonplaceholder.typicode.com/posts?_page=$_page&_limit=$_limit';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      if (data.isNotEmpty) {
        _posts.addAll(data.map((json) => Post.fromJson(json)).toList());
        _page++;
      } else {
        _hasMore = false; // No more data
      }
    } else {
      throw Exception('Failed to load posts');
    }

    _isLoading = false;
    notifyListeners();
  }
}
