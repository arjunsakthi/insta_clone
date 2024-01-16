import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.messenger_outline),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                  height: MediaQuery.sizeOf(context).width * 0.6,
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  child: CircularProgressIndicator(color: primaryColor),
                ),
              );
            }
            print(snapShot.data);
            return ListView.builder(
                itemCount: snapShot.data!.docs.length,
                itemBuilder: (context, idx) =>
                    PostCard(snap: snapShot.data!.docs[idx]));
          }),
    );
  }
}
