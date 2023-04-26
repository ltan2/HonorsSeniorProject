import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/mood.dart';
import 'package:mobile_app/models/post.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/models/favorite.dart';
import 'package:mobile_app/screens/main/posts/list.dart';
import 'package:mobile_app/screens/main/profile/newProfile.dart';
import 'package:mobile_app/screens/main/profile/activities.dart';
import 'package:mobile_app/services/posts.dart';
import 'package:mobile_app/services/user.dart';

class Recommend extends StatefulWidget {
  final uid;
  Recommend(this.uid, {Key? key}) : super(key: key);

  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  String journal = "";
  bool calcRec = true;
  UserService _userService = UserService();
  PostService _postService = PostService();
  
  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController = TextEditingController();

    return MultiProvider(
        providers: [
          StreamProvider<List<MoodModel>>.value(
            initialData:[],
            value:_userService.getSentiment(widget.uid),
          ),
          StreamProvider<List<PostModel>>.value(
            initialData:[],
            value: _postService.getPostsByUser(widget.uid),
          ),
        ],
      child: Column (
        children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Expanded (
                child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "My day has been...",
                          ),
                          // onChanged: (val) => setState(() {
                          //   journal = val;
                          // }),
                          controller: _textEditingController,
                        ),
                        SizedBox(height: 2.0),
                        ElevatedButton(
                          child: Text("Save"),
                          onPressed: () async => {
                              print(_textEditingController.text),
                              await _userService.saveMood(widget.uid,_textEditingController.text),
                              _textEditingController.text = "",
                              setState(() {
                                journal = "";
                              })
                            }
                        ),
                        SizedBox(
                          height: 5
                        ),
                      ]
                    )
                  )
                //)
              )
            ),
            calcRec ? 
            Padding(padding: EdgeInsets.all(10),
            child: Activities(widget.uid) ):
            Text("Input how your day went. We will evaluate the sentiment of your text and recommend activities from there")
        ]
      )
    );
  }
}
