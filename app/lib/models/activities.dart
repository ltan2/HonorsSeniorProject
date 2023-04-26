import 'package:mobile_app/screens/main/profile/activities.dart';

class ActivityModel {
  final String id;
  final String activity;
  final int score;

  ActivityModel(
    {
      required this.id,
      required this.activity,
      required this.score,
    }
  );
}