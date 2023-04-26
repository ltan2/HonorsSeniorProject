import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/mood.dart';
import 'package:mobile_app/models/post.dart';
import 'package:mobile_app/models/activities.dart';
import 'package:provider/provider.dart';
import 'package:dart_sentiment/dart_sentiment.dart';   
import 'package:mobile_app/screens/main/profile/suggestions.dart'; 
import 'package:mobile_app/services/utils.dart';
import 'package:mobile_app/services/user.dart';
import 'dart:convert';

class Activities extends StatefulWidget {
  final uid;
  Activities(this.uid, {Key? key}) : super(key: key);

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  UtilsService _utilsService = UtilsService();
  UserService _userService = UserService();

  @override
  
  Widget build(BuildContext context) {
    final texts = Provider.of<List<MoodModel>>(context);
    final posts = Provider.of<List<PostModel>>(context);
    var score_texts = 0.0;
    score_texts = analyzeScore(texts);
    var score_posts = 0.0;
    score_posts = analyzeScorePosts(posts);
    var totalScore = (score_posts + score_texts)/2;
    if(score_posts == 0.0){
      totalScore = score_texts;
    }else if(score_texts == 0.0){
      totalScore = score_posts;
    }
    return MultiProvider(
      providers: [
        StreamProvider<List<ActivityModel>>.value(
          initialData:[],
          value:_utilsService.getUserActivity(widget.uid),
        ),
        StreamProvider<List<MoodModel>>.value(
            initialData:[],
            value:_userService.getSentiment(widget.uid),
        )
      ], 
      child: Expanded(
        child: SingleChildScrollView(
            child: Wrap(
              children: [
                Column (
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.0),
                      child: Text("Posts sentiment score: \"$score_posts%\"")
                    ),
                    Container(
                      padding: EdgeInsets.all(2.0),
                      child: Text("Day entries score: \"$score_texts%\"")
                    ),
                    SizedBox(height:2.0),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                      children: [
                        Container(
                          child: Text(
                            "😠",
                          ),
                        ),
                        Container(
                            width: totalScore * (MediaQuery.of(context).size.width - 20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [(Colors.red[900])!, (Colors.green[900])!],
                              ),
                            ),
                            child: Text(
                              "$totalScore%",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ),
                        Container(
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[900]!),
                          ),
                        ),
                        Container(
                          child: Text(
                            "😊",
                          ),
                        )
                      ],
                    )
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    child: Text("Our verdict: "),
                  ),
                  SizedBox(height: 5.0),
                  MoodScreen(widget.uid, totalScore),
                ]
              )
            ]
          )
        ),
      )
    );
  }

  analyzeScore(var texts) {
    double totalScore = 0.0;
    final sentiment = Sentiment();  
    try{  
	  for(int i=0;i < texts.length;i++){
      MoodModel mood = texts[i];
      var x = jsonEncode(sentiment.analysis(mood.details.toString()));
      var comp = jsonDecode(x)["comparative"];
      totalScore += comp;
    }  
    if(texts.length > 0){
      totalScore = totalScore / texts.length;
    }
    else{
      totalScore = 0.0;
    }
    }catch(e){
      print(e);
      totalScore = 0.0;
    }
    double num1 = double.parse((totalScore).toStringAsFixed(2));
    return num1;
  }

  analyzeScorePosts(var texts) {
    double totalScore = 0.0;
    try{
      final sentiment = Sentiment();    
      for(int i=0;i < texts.length;i++){
        PostModel post = texts[i];
        try{
          var x = jsonEncode(sentiment.analysis(post.text.toString()));
          var comp = jsonDecode(x)["comparative"];
          totalScore += comp;
        }catch(err){}
      }  
      print(totalScore);
    }catch(err){
      print(err);
    }
    if(texts.length >0 ){
      double finalScore = totalScore/texts.length;
      return finalScore;
    }else{
      return 0.0;
    }
  }
}