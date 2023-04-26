import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;
  String? creator;
  String? text;
  Timestamp timestamp;
  bool? retweet;
  int? likesCount;
  String? originalId;
  DocumentReference? ref;
  bool ? isReply;


  PostModel(
      { this.id,
      this.creator,
      this.text,
      required this.timestamp,
      this.retweet,
      this.likesCount,
      this.originalId,
      this.ref,
      this.isReply
});
}