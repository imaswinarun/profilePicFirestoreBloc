import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:profilePiCTask/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('USERS');

  Future<UserModel> getUserInfo() async {
    UserModel userModel = UserModel(imgUrl: '', userId: 0, name: '', uKey: '');
    try {
      QuerySnapshot querySnapshot =
          await _usersCollection.where("userId", isEqualTo: 1).get();
      for (var doc in querySnapshot.docs) {
        userModel = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Excetion in firestore');
    }
    return userModel;
  }

  Future<bool> updateInfo(String url, String name, String uKey) async {
    bool complete = false;
    try {
      _usersCollection.doc(uKey).update({
        "imgUrl": url,
        "name": name,
        "uKey": uKey,
      });
      complete = true;
    } catch (e) {
      complete = false;
      print('Excetion in firestore');
    }
    return complete;
  }

  Future<UploadTask> upLoadImage(String imagePath) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('Profile_Images')
        .child('/abc.jpg');
    final metaData = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': imagePath});

    UploadTask uploadTask = ref.putFile(File(imagePath), metaData);
    UploadTask up = await Future.value(uploadTask);
    return up; //Future.value(uploadTask);
  }
}
