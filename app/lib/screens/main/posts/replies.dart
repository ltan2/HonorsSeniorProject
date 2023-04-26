import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/models/post.dart';
import 'package:mobile_app/screens/main/posts/list.dart';
import 'package:mobile_app/screens/main/posts/replyform.dart';
import 'package:mobile_app/services/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Replies extends StatefulWidget {
  Timestamp timestamp = Timestamp(00,0);
  Replies({Key? key}) : super(key: key);

  @override
  _RepliesState createState() => _RepliesState();
}


class _RepliesState extends State<Replies> {  
  PostService _postService = PostService();
  
  @override
  Widget build(BuildContext context) {
    Object? args = ModalRoute.of(context)?.settings.arguments;
    PostModel argsModel = args as PostModel;
    return FutureProvider.value(
        value: _postService.getReplies(argsModel),
        initialData: [PostModel(id: "12", creator: "Errpr", text: "Err", 
                      timestamp: widget.timestamp , retweet: false, likesCount: 0,
                      originalId: "", ref: null)],
        child: Container(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Replies"),
            ),
            body: Container(
              child: Column(
                children: [
                  _buildReplyForm(context),
                  ReplyForm(argsModel)
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildReplyForm(BuildContext context) {
    PostService _postService = PostService();
    Object? args = ModalRoute.of(context)?.settings.arguments;
    PostModel argsModel = args as PostModel;
    return Expanded(
      child: ListPosts(argsModel)
    );
  }

  
}