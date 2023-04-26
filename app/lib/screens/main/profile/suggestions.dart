
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:mobile_app/models/activities.dart';
import 'package:provider/provider.dart';

import 'package:mobile_app/services/utils.dart';


class MoodScreen extends StatefulWidget {
  final uid;
  final score;
  MoodScreen(this.uid, this.score, {Key? key}) : super(key: key);

  @override
  _MoodScreenState createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  UtilsService utilsService = UtilsService();
  List<ActivityModel> generateActivity(List<ActivityModel> activity_list) {
    activity_list.sort((a, b) => b.score.compareTo(a.score));
    return activity_list;
  }
  List<Color> thumbColors = [];


  @override
  Widget build(BuildContext context) {
    List<ActivityModel> unsorted_list = Provider.of<List<ActivityModel>>(context);
    final activity_list = generateActivity(unsorted_list);
    thumbColors = List.filled(activity_list.length, Colors.grey);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: activity_list.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(activity_list[index].activity.toString()),
          trailing: ThumbIcon(
            activityId: activity_list[index].id,
            uid: widget.uid,
            activity: activity_list[index].activity,
            score: activity_list[index].score,
            utilsService: utilsService,
          ),
        );
      },
    );
  }
}

class ThumbIcon extends StatefulWidget {
  final String activityId;
  final String uid;
  final String activity;
  final int score;
  final UtilsService utilsService;

  ThumbIcon({
    required this.activityId,
    required this.uid,
    required this.activity,
    required this.score,
    required this.utilsService,
  });

  @override
  _ThumbIconState createState() => _ThumbIconState();
}

class _ThumbIconState extends State<ThumbIcon> {
  Color thumbColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 10),
        decoration: BoxDecoration(
          color: thumbColor,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.thumb_up, color: Colors.white),
      ),
      onPressed: () {
        widget.utilsService.updateActivityRank(
          widget.activity, 
          widget.activityId, 
          widget.uid, 
          widget.score
        );
        setState(() {
          thumbColor = Colors.blue;
        });
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            thumbColor = Colors.grey;
          });
        });
      },
    );
  }
}




