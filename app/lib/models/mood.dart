import 'package:cloud_firestore/cloud_firestore.dart';

class MoodModel {
  final String details;
  final Timestamp date;

  MoodModel(
      {required this.details,
      required this.date,
      });
}