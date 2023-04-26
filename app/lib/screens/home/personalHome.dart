import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/screens/main/posts/list.dart';
import 'package:mobile_app/services/posts.dart';
import 'package:mobile_app/models/post.dart';

class PHome extends StatefulWidget {
  PHome({Key? key}) : super(key: key);

  @override
  PHomeState createState() => PHomeState();
}

class PHomeState extends State<PHome> {
  @override
  Widget build(BuildContext context) {
    PostService _postService = PostService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Feed'),
      ),
      body: FutureProvider<List<PostModel>>.value(
        value: _postService.getFeed(),
        initialData: [],
        child: 
        Scaffold(body: ListPosts(null), 
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
            child: Icon(Icons.add))),
    ));
  }
}