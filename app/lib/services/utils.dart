import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mobile_app/models/activities.dart';
import 'package:mobile_app/screens/main/profile/activities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UtilsService {
  Future<String> uploadFile(File _image, String path) async {
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref(path);

    firebase_storage.UploadTask uploadTask = storageReference.putFile(_image);

    await uploadTask.whenComplete(() => null);
    String returnURL = '';
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  Future updateActivityRank(activity, doc_id, uid, score) async {
    print(doc_id);
    print(uid);
    int value = score + 1;
    print(value);
    await FirebaseFirestore.instance.collection("activity").doc(uid).
    collection("activities").doc(doc_id).set({
      "activity": activity,
      "score" : value
    });
  }

  Stream<List<ActivityModel>> getUserActivity(uid){

    return FirebaseFirestore.instance
      .collection("activity")
      .doc(uid)
      .collection("activities")
      .snapshots()
      .map(_activityFromQuerySnapshot);
  }

  List<ActivityModel> _activityFromQuerySnapshot(QuerySnapshot snapshot) {
    var lis = snapshot.docs.map((doc) {
      return ActivityModel(
        id: doc.id,
        activity: doc["activity"],
        score: doc["score"]
      );
    }).toList();
    return lis;
  }
}