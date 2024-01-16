import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uuid;
  final String postId;
  final String userName;
  final String postUrl;
  final String profImage;
  final datePublished;
  final List Likes;

  Post({
    required this.description,
    required this.uuid,
    required this.postId,
    required this.postUrl,
    required this.profImage,
    required this.userName,
    required this.datePublished,
    required this.Likes,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uuid,
        'postId': postId,
        'postUrl': postUrl,
        'profImage': profImage,
        'userName': userName,
        'datePublished': datePublished,
        'Likes': Likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data();
    return Post(
      description: snap['description'],
      uuid: snap['uid'],
      postId: snap['postId'],
      postUrl: snap['postUrl'],
      profImage: snap['profImage'],
      userName: snap['userName'],
      datePublished: snap['datePublished'],
      Likes: snap['Likes'],
    );
  }
}
