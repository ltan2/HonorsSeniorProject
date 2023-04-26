import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class ScoreAvatar extends StatelessWidget {
  int score = 0;
  int avatarSize = 80;

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: Colors.yellowAccent,
      endRadius: 80.0,
      duration: Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 100),
      child: CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: Text(
          '$score',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
