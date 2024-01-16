import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/model/post.dart';
import 'package:insta_clone/resource/storage_methods.dart';
import 'package:uuid/uuid.dart';

class Firestore {
  final _fireStore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    String uuid,
    Uint8List file,
    String username,
    String profImage,
  ) async {
    String res = "Some Error Occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = Uuid().v1();
      Post post = Post(
        description: description,
        uuid: uuid,
        postId: postId,
        postUrl: photoUrl,
        profImage: profImage,
        userName: username,
        datePublished: DateTime.now(),
        Likes: [],
      );
      _fireStore.collection('posts').doc(postId).set(post.toJson());
      res = 'Successfully Posted';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(
      {required String postId,
      required String uuid,
      required List likes}) async {
    print('object');
    try {
      if (likes.contains(uuid)) {
        _fireStore.collection('posts').doc(postId).update({
          'Likes': FieldValue.arrayRemove([uuid])
        });
      } else {
        _fireStore.collection('posts').doc(postId).update({
          'Likes': FieldValue.arrayUnion([uuid])
        });
        print('added');
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<String> storeComment(String userName, String userId, String comment,
      String postId, String profilePic) async {
    String res = 'There is Some Error !!';
    try {
      if (comment.isNotEmpty) {
        final String commentId = Uuid().v1();
        await _fireStore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'userName': userName,
          'comment': comment,
          'uuid': userId,
          'datePublished': DateTime.now(),
        });
        print(comment);
        res = 'Successfully Commented';
      } else {
        print('Comment is Empty');
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> deletePost(String postId) async {
    try {
      await _fireStore.collection('posts').doc(postId).delete();
      print("Successfully Deleted the post");
    } catch (err) {
      print(err.toString());
    }
  }
}
