import 'package:flutter/material.dart';
import 'package:mobile_app/models/post.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/services/posts.dart';

class ItemPost extends StatefulWidget {
  final PostModel post;
  final AsyncSnapshot<UserModel> snapshotUser;
  final AsyncSnapshot<bool> snapshotLike;
  final AsyncSnapshot<bool> snapshotRetweet;
  final bool retweet;
  final bool isReply;

  ItemPost(this.post, this.snapshotUser, this.snapshotLike,
      this.snapshotRetweet, this.retweet, this.isReply,
      {Key? key})
      : super(key: key);

  @override
  _ItemPostState createState() => _ItemPostState();
}

class _ItemPostState extends State<ItemPost> {
  PostService _postService = PostService();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, '/profile', arguments: widget.snapshotUser.data?.id),
    child: ListTile(
      title: Padding(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.retweet)
                Text("Shared post"), 
              SizedBox(height: 20),
              Row(
                children: [
                  widget.snapshotUser.data?.profileImageUrl != ''
                      ? CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              widget.snapshotUser.data?.profileImageUrl ?? ""))
                      : Icon(Icons.person, size: 40),
                  SizedBox(width: 10),
                  Text(widget.snapshotUser.data?.name ?? "")
                ],
              ),
            ],
          )),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.post.text ?? ""),
                SizedBox(height: 20),
                Text(widget.post.timestamp?.toDate().toString() ?? ""),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: new Icon(
                              Icons.chat_bubble_outline,
                                color: Colors.blue, size: 30.0),
                            onPressed: () => Navigator.pushNamed(
                                context, '/replies',
                                arguments: widget.post)),
                      ],
                    ),
                    widget.isReply ?
                    IconButton(icon: new Icon(null), onPressed: null ):
                    Row(
                      children: [
                        IconButton(
                            icon: new Icon(
                                widget.snapshotRetweet.data ?? false
                                    ? Icons.cancel
                                    : Icons.repeat,
                                color: Colors.blue,
                                size: 30.0),
                            onPressed: () async {
                            await _postService.retweet(widget.post, widget.snapshotRetweet.data ?? false);
                            }
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: new Icon(
                                widget.snapshotLike.data ?? false
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.blue,
                                size: 30.0),
                            onPressed: () {
                              _postService.likePost(
                                  widget.post, widget.snapshotLike.data ?? false);
                            }
                        ),
                        Text("5"),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(),
        ],
      ),
    ));
  }
}