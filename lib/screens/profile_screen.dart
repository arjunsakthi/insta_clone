import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var data = {};
  int postCount = 0;
  bool _isfollowing = false;
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      var postsnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();

      data = snap.data()!;
      postCount = postsnap.docs.length;
      _loading = false;
      _isfollowing =
          data['followers'].contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(
            child: Container(
              height: MediaQuery.sizeOf(context).width * 0.6,
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: CircularProgressIndicator(
                color: primaryColor,
                strokeWidth: 10,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(data['username']!),
            ),
            body: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(children: [
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        clipBehavior: Clip.hardEdge,
                        child: FadeInImage(
                          placeholder: AssetImage(
                              'assets/profile.webp'), //MemoryImage(kTransparentImage),
                          image: NetworkImage(
                            data['photoUrl'],
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Column(children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStateColumn(postCount, 'Posts'),
                              buildStateColumn(
                                  data['followers'].length, 'Followers'),
                              buildStateColumn(
                                  data['following'].length, 'Following'),
                            ],
                          ),
                          FirebaseAuth.instance.currentUser!.uid == widget.uid
                              ? FollowButton(
                                  function: () {},
                                  backgroundColor: mobileBackgroundColor,
                                  label: 'Edit profile',
                                )
                              : _isfollowing
                                  ? FollowButton(
                                      function: () {},
                                      backgroundColor: Colors.white,
                                      label: 'Unfollow',
                                    )
                                  : FollowButton(
                                      function: () {},
                                      backgroundColor: blueColor,
                                      label: 'follow',
                                    ),
                        ]),
                      )
                    ]),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        data['username'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 2),
                      child: Text(
                        data['bio'],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 2,
                    ),
                    FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('posts')
                            .where('uid', isEqualTo: widget.uid)
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: Container(
                                height: MediaQuery.sizeOf(context).width * 0.6,
                                width: MediaQuery.sizeOf(context).width * 0.6,
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                  strokeWidth: 10,
                                ),
                              ),
                            );
                          }
                          return GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 150,
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                            ),
                            itemCount: snap.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot currentsnap =
                                  snap.data!.docs[index];
                              return FadeInImage.assetNetwork(
                                  fit: BoxFit.contain,
                                  placeholder: 'assets/placeholder.jpg',
                                  image: currentsnap['postUrl']);
                            },
                          );
                        })
                  ],
                ),
              )
            ]),
          );
  }

  Column buildStateColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
