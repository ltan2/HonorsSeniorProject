import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/services/utils.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/models/favorite.dart';
import 'package:mobile_app/models/mood.dart';
import 'package:dart_sentiment/dart_sentiment.dart';    


class UserService {
  UtilsService _utilsService = UtilsService();

  UserModel _userFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      id: snapshot.id,
      name: snapshot['name'] ?? "",
      profileImageUrl: snapshot['profileImageUrl'] ?? "",
      bannerImageUrl: snapshot['bannerImageUrl'] ?? "",
      email: snapshot['email'] ?? "",
    );
  }

  List<UserModel> _userListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
        id: doc.id,
        name: doc['name'] ?? "",
        profileImageUrl: doc['profileImageUrl'] ?? "",
        bannerImageUrl: doc['bannerImageUrl'] ?? "",
        email: doc['email'] ?? "",
      );
    }).toList();
  }

  List<FavModel> _favListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FavModel(
        name: doc['name'] ?? "",
        interest: doc['interest'] ?? "",
        description: doc['description'] ?? "",
      );
    }).toList();
  }

  List<MoodModel> _moodFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MoodModel(
        details: doc["details"],
        date: doc["date"]
      );
    }).toList();
  }
  
  Stream<UserModel> getUserInfo(uid) {
  return FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .snapshots()
      .map(_userFromFirebaseSnapshot);
  }

  Stream<List<FavModel>> getUserFav(uid, interest) {
  return FirebaseFirestore.instance
      .collection("favorite")
      .doc(uid)
      .collection(interest)
      .snapshots()
      .map(_favListFromQuerySnapshot);
  }

  Stream<List<UserModel>> queryByName(search) {
    return FirebaseFirestore.instance
        .collection("users")
        .orderBy("name")
        .startAt([search])
        .endAt([search + '\uf8ff'])
        .limit(10)
        .snapshots()
        .map(_userListFromQuerySnapshot);
  }

  Future<void> updateProfile(File? _bannerImage, File? _profileImage, String name) async {
    String bannerImageUrl = '';
    String profileImageUrl = '';

    if (_bannerImage != null) {
      bannerImageUrl = await _utilsService.uploadFile(_bannerImage,
          'user/profile/${FirebaseAuth.instance.currentUser?.uid}/banner');
    }
    if (_profileImage != null) {
      profileImageUrl = await _utilsService.uploadFile(_profileImage,
          'user/profile/${FirebaseAuth.instance.currentUser?.uid}/profile');
    }

    Map<String, Object> data = new HashMap();
    if (name != '') data['name'] = name;
    if (bannerImageUrl != '') data['bannerImageUrl'] = bannerImageUrl;
    if (profileImageUrl != '') data['profileImageUrl'] = profileImageUrl;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update(data);
  }

  Stream<bool> isFollowing(uid, otherId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("following")
        .doc(otherId)
        .snapshots()
        .map((snapshot) {
      return snapshot.exists;
    });
  }

  Future<void> followUser(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('following')
        .doc(uid)
        .set({});

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('followers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({});
  }

  Future<void> unfollowUser(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('following')
        .doc(uid)
        .delete();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('followers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .delete();
  }

  Future<List<String>> getUserFollowing(uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('following')
        .get();

    final users = querySnapshot.docs.map((doc) => doc.id).toList();
    return users;
  }
  
  Future saveFav(uid, category, name, interest, description) async {
    await FirebaseFirestore.instance.collection("favorite").doc(uid).collection(category).add({
      'name': name,
      'interest': interest,
      'description': description,
    });
  }

  Future saveMood(uid, text) async {
    await FirebaseFirestore.instance.collection("diary").doc(uid).collection("myday").add({
      'details': text,
      'date': FieldValue.serverTimestamp(),
    });
  }


  Stream<List<MoodModel>> getSentiment(uid){
    // final Timestamp now = Timestamp.fromDate(DateTime.now());
    // final Timestamp yesterday = Timestamp.fromDate(
    //   DateTime.now().subtract(const Duration(days: 1)),
    // );

    return FirebaseFirestore.instance
      .collection("diary")
      .doc(uid)
      .collection("myday")
      .snapshots()
      .map(_moodFromQuerySnapshot);
  
  }

}