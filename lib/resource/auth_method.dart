import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_clone/model/user.dart' as model;
import 'package:insta_clone/resource/storage_methods.dart';

class AuthMehtods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //to fetch current user's data
  Future<model.user> getUserData() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot<Map<String, dynamic>> snap =
        await _fireStore.collection('users').doc(currentUser.uid).get();
    return model.user.fromSnap(snap);
  }

  // sign up user
  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Some Error Ocurred';

    try {
      // registering user
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          bio.isNotEmpty &&
          file.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('ProfilePics', file, false);

        print("uid :" + cred.user!.uid);

        // add user to our database

        model.user user = model.user(
            bio: bio,
            username: username,
            uuid: cred.user!.uid,
            email: email,
            followers: [],
            following: [],
            photoUrl: photoUrl);

        await _fireStore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        //second method with this document id and uid will be different
        // await _fireStore.collection('users').add(
        //   {
        //     'username': username,
        //     'uid': cred.user!.uid,
        //     'email': email,
        //     'bio': bio,
        //     'followers': [],
        //     'following': [],
        //   },
        // );
        res = 'Successfully Registered';
      }
    } catch (e) {
      print('got error !!');
      res = e.toString();
    }

    return res;
  }

  // Logging in user
  Future<String> LoginUser(String email, String password) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Successfully Loged in";
      } else {
        res = "Please Fill All the Details";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
