import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:insta_clone/model/user.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // adding image to firebase storage
  uploadImageToStorage(String childName, Uint8List file, bool isPost) async {
    Reference ref = _storage.ref().child(childName).child(
        _auth.currentUser!.uid); // for choosing folder in firebase storage

    if (isPost) {
      final post_id = Uuid().v1(); // timely generated id
      ref = ref.child(
          post_id); // make a folder such that each user.id can have multiple posts.
    }
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
