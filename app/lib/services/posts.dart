import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile_app/models/post.dart';
import 'package:mobile_app/services/user.dart';
import 'package:quiver/iterables.dart';

class PostService {
  Future savePost(text) async {
    await FirebaseFirestore.instance.collection("posts").add({
      'text': text,
      'creator': FirebaseAuth.instance.currentUser?.uid,
      'timestamp': FieldValue.serverTimestamp(),
      'retweet': false,
      'likesCount': 0,
    });
  }

  Future reply(PostModel post, String text) async {
    if (text == '') {
      return;
    }
    await post.ref?.collection("replies").add({
      'text': text,
      'creator': FirebaseAuth.instance.currentUser?.uid,
      'timestamp': FieldValue.serverTimestamp(),
      'retweet': false,
      'likesCount': 0,
      'isReply' : true
    });
  }

  List<PostModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      int count = 0;
      String o_id = "";
      bool reply = false;
      try{
        if(doc.get("likesCount") != null){
          count = doc["likesCount"];
        }
      }
      catch(e){
        print(e);
      }
      try{
        if(doc.get("originalId") != null){
          o_id = doc["originalId"];
        }
      }
      catch(e){
        print(e);
      }
      try{
        if(doc.get("isReply") != null){
          reply = doc["isReply"];
        }
      }
      catch(e){
        print(e);
      }
      return PostModel(
        id: doc.id,
        text: doc['text'] ?? '',
        creator: doc['creator'] ?? '',
        timestamp: doc["timestamp"] ?? 0,
        retweet: doc["retweet"] ?? false,
        likesCount: count,
        originalId: o_id,
        ref: doc.reference,
        isReply: reply
      );
    }).toList();
  }

  PostModel? _postFromSnapshot(DocumentSnapshot snapshot) {
    int count = 0;
    String o_id = "";
    bool reply = false;
    try{
      if(snapshot.get("likesCount") != null){
        count = snapshot["likesCount"];
      }
    }
    catch(e){
      print(e);
    }
    try{
      if(snapshot.get("originalId") != null){
        o_id = snapshot["originalId"];
      }
    }
    catch(e){
      print(e);
    }
    try{
      if(snapshot.get("isReply") != null){
        reply = snapshot["isReply"];
      }
    }
    catch(e){
      print(e);
    }
    return snapshot.exists
        ? PostModel(
        id: snapshot.id,
        text: snapshot['text'] ?? '',
        creator: snapshot['creator'] ?? '',
        timestamp: snapshot["timestamp"] ?? 0,
        retweet: snapshot["retweet"] ?? false,
        likesCount: count,
        originalId: o_id,
        isReply: reply
      )
      : null;
  }

  Stream<List<PostModel>> getPostsByUser(uid){
    return FirebaseFirestore.instance
        .collection("posts")
        .where('creator', isEqualTo: uid)
        .snapshots()
        .map(_postListFromSnapshot);
  }

  Future<List<PostModel>> getFeed() async {
    List<String> usersFollowing = await UserService() 
        .getUserFollowing(FirebaseAuth.instance.currentUser?.uid);

    var splitUsersFollowing = partition<dynamic>(usersFollowing, 10);

    List<PostModel> feedList = [];

    for (int i = 0; i < splitUsersFollowing.length; i++) {
      inspect(splitUsersFollowing.elementAt(i));
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('creator', whereIn: splitUsersFollowing.elementAt(i))
          .orderBy('timestamp', descending: true)
          .get();

      feedList.addAll(_postListFromSnapshot(querySnapshot));
    }

    feedList.sort((a, b) {
      var adate = a.timestamp;
      var bdate = b.timestamp;
      return bdate.compareTo(adate);
    });

    return feedList;
  }

  Future likePost(PostModel post, bool current) async {
    if (current) {
      // post.likesCount = post.likesCount - 1 ;
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(post.id)
          .collection("likes")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .delete();
    }
    if (!current) {
      // post.likesCount = post.likesCount + 1;

      await FirebaseFirestore.instance
          .collection("posts")
          .doc(post.id)
          .collection("likes")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({});
    }
  }

  Stream<bool> getCurrentUserLike(PostModel? post) {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(post?.id)
        .collection("likes")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.exists;
    });
  }

  Future retweet(PostModel post, bool current) async {
    if (current) {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(post.id)
          .collection("retweets")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .delete();

      await FirebaseFirestore.instance
          .collection("posts")
          .where("originalId", isEqualTo: post.id)
          .where("creator", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((value) {
        if (value.docs.length == 0) {
          return;
        }
        FirebaseFirestore.instance
            .collection("posts")
            .doc(value.docs[0].id)
            .delete();
      });
      // Todo remove the retweet
      return;
    }
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(post.id)
        .collection("retweets")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({});

    await FirebaseFirestore.instance.collection("posts").add({
      'creator': FirebaseAuth.instance.currentUser?.uid,
      'timestamp': FieldValue.serverTimestamp(),
      'retweet': true,
      'originalId': post.id,
      'likesCount': 0,
      'text': "",
    });
  }

  Stream<bool> getCurrentUserRetweet(PostModel? post) {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(post?.id)
        .collection("retweets")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.exists;
    });
  }

  Future<PostModel?> getPostById(String id) async {
    DocumentSnapshot postSnap =
        await FirebaseFirestore.instance.collection("posts").doc(id).get();

    return _postFromSnapshot(postSnap);
  }

  Future<List<PostModel>> getReplies(PostModel post) async {
    QuerySnapshot? querySnapshot = await post.ref?.collection("replies")
    .orderBy('timestamp', descending: true)
    .get(); 

    if(querySnapshot != null){
        return _postListFromSnapshot(querySnapshot);
    }
    else{
      return [];
    }
  }

}