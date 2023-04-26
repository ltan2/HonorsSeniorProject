import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/models/post.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/screens/main/posts/item.dart';
import 'package:mobile_app/services/posts.dart';
import 'package:mobile_app/services/user.dart';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';


class ReplyForm extends StatefulWidget {
  PostModel? post;
  Timestamp timestamp = Timestamp(00,0);
  ReplyForm(this.post, {Key? key}) : super(key: key);

  @override
  _ReplyFormState createState() => _ReplyFormState();
}

class _ReplyFormState extends State<ReplyForm> {
  final TextEditingController _textEditingController = TextEditingController();
  UserService _userService = UserService();
  PostService _postService = PostService();
  String text = '';
  
  @override
  Widget build(BuildContext context) {
    Object? args = ModalRoute.of(context)?.settings.arguments;
    PostModel argsModel = args as PostModel;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Form(
            child: TextFormField(
            controller: _textEditingController,
            )
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                  return states.contains(MaterialState.pressed) ? Colors.grey : Colors.blue;
                }),
                foregroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                  return states.contains(MaterialState.pressed) ? Colors.black : Colors.white;
                }),
              ),
              onPressed: () async {
                await _postService.reply(argsModel, _textEditingController.text);
                _textEditingController.text = '';
                Navigator.popAndPushNamed(context,'/replies', arguments: widget.post );
              },
              child: Text("Reply"))
        ],
      ),
    );
  }
}