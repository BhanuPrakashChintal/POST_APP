import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Post model
class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

// PostProvider for state management
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

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Posts App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    postProvider.fetchPosts(); // Fetch initial posts

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        postProvider.fetchPosts(); // Fetch more posts when reaching the bottom
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          if (postProvider.isLoading && postProvider.posts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount:
                postProvider.posts.length + (postProvider.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == postProvider.posts.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final post = postProvider.posts[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    post.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, // Bold text
                      fontSize: 20, // Increase font size
                    ),
                  ),
                  subtitle: Text(post.body),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
