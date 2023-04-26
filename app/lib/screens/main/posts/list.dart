import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/models/post.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/screens/main/posts/item.dart';
import 'package:mobile_app/services/posts.dart';
import 'package:mobile_app/services/user.dart';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';


class ListPosts extends StatefulWidget {
  PostModel? post;
  Timestamp timestamp = Timestamp(00,0);
  ListPosts(this.post, {Key? key}) : super(key: key);


  @override
  _ListPostsState createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  UserService _userService = UserService();
  PostService _postService = PostService();
  @override
  Widget build(BuildContext context) {
    List<PostModel> posts = Provider.of<List<PostModel>>(context);
    if (widget.post != null) {
      posts.insert(0, widget.post ?? PostModel(id: "12", creator: "Errpr", text: "Err", 
                      timestamp: widget.timestamp , retweet: false, likesCount: 0,
                      originalId: "", ref: null));
    }
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        if (post.retweet ?? false) {
          return FutureBuilder<PostModel?>(
              future: _postService.getPostById(post.originalId ?? ""),
              builder: (BuildContext context,
                  AsyncSnapshot<PostModel?> snapshotPost) {
                if (!snapshotPost.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                if(snapshotPost.data != null){
                  return mainPost(snapshotPost.data , true);
                }else{
                  return Text("Error");
                }
              });
        }  
        return mainPost(post, false);
      },
    );
  }

  StreamBuilder<UserModel> mainPost(PostModel? post, bool retweet) {
    return StreamBuilder(
        // ignore: unnecessary_null_in_if_null_operators
        stream: _userService.getUserInfo(post?.creator),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshotUser) {
          if (!snapshotUser.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          //stream builder to get user like
          return StreamBuilder(
              stream: _postService.getCurrentUserLike(post ?? null),
              builder:
                  (BuildContext context, AsyncSnapshot<bool> snapshotLike) {
                if (!snapshotLike.hasData) {
                  return Center(child: CircularProgressIndicator());
                } //stream builder to get user like

                return StreamBuilder(
                    stream: _postService.getCurrentUserRetweet(post ?? null),
                    builder: (BuildContext context,
                        AsyncSnapshot<bool> snapshotRetweet) {
                      if (!snapshotLike.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ItemPost(post ?? 
                      PostModel(id: "12", creator: "Errpr", text: "Err", 
                      timestamp: widget.timestamp , retweet: false, likesCount: 0,
                      originalId: "", ref: null)
                      , snapshotUser, snapshotLike,
                          snapshotRetweet, retweet, post?.isReply ?? false );
                    });
              });
        });
  }
}