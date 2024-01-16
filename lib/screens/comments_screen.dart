import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/model/user.dart' as model;
import 'package:insta_clone/provider/user_provider.dart';
import 'package:insta_clone/resource/firestore.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  CommentScreen({super.key, required this.snap});
  final snap;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late TextEditingController commentController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model.user user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: mobileBackgroundColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                height: MediaQuery.sizeOf(context).width * 0.6,
                width: MediaQuery.sizeOf(context).width * 0.6,
                child: CircularProgressIndicator(color: primaryColor),
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, idx) => CommentCard(
                    snap: snapshot.data!.docs[idx],
                  ));
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 8),
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
          child: Row(children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(user.photoUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Comment as ${user.username}'),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                String res = await Firestore().storeComment(
                    widget.snap['userName'],
                    widget.snap['uid'],
                    commentController.text,
                    widget.snap['postId'],
                    widget.snap['postUrl']);
                showSnackBar(res, context);
                commentController.clear();
                if (res == 'Successfully Commented') {
                  commentController.clear();
                }
              },
              child: Container(
                child: Text(
                  'Post',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
