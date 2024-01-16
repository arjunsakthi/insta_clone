import 'package:cloud_firestore/cloud_firestore.dart';

class user {
  final String email;
  final String uuid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  user({
    required this.username,
    required this.email,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
    required this.uuid,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uuid,
        'email': email,
        'bio': bio,
        'followers': followers,
        'following': following,
        'photoUrl': photoUrl,
      };

  static user fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data();
    return user(
      username: snap['username'],
      email: snap['email'],
      bio: snap['bio'],
      photoUrl: snap['photoUrl'],
      followers: snap['followers'],
      following: snap['following'],
      uuid: snap['uid'],
    );
  }
}
