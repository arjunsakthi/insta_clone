import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/model/user.dart' as model;
import 'package:insta_clone/provider/user_provider.dart';
import 'package:insta_clone/resource/firestore.dart';
import 'package:insta_clone/screens/comments_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCommentLength();
  }

  getCommentLength() async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get(); // we will get a list of comments ,which is in comments collection
      setState(() {
        commentLength = snap.docs.length;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  int commentLength = 0;
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    final model.user user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Hearder Section
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(right: 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      widget.snap['profImage'],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        children: [
                          Text(
                            widget.snap['userName'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ListView(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: ['Delete']
                                .map(
                                  (e) => InkWell(
                                    onTap: () async {
                                      await Firestore()
                                          .deletePost(widget.snap['postId']);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      child: Text(e),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.more_vert),
                  )
                ],
              ),
            ),

            // post Description
            GestureDetector(
              onDoubleTap: () async {
                await Firestore().likePost(
                    likes: widget.snap['Likes'],
                    postId: widget.snap['postId'],
                    uuid: widget.snap['uid']);

                print(widget.snap['Likes'].length);
                setState(() {
                  isLikeAnimating = true;
                });
              },
              child: Stack(alignment: Alignment.center, children: [
                Container(
                  color: Colors.grey,
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  child: FadeInImage.assetNetwork(
                      fit: BoxFit.contain,
                      placeholder: 'assets/placeholder.jpg',
                      image: widget.snap['postUrl']),
                  // Image.network(
                  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSol1LzIVjvyTNtoVc_0wdw9cN8f-6BHl47lQ&usqp=CAU',
                  //   fit: BoxFit.contain,
                  // ),
                ),
                AnimatedOpacity(
                  opacity: isLikeAnimating ? 1 : 0,
                  duration: Duration(milliseconds: 200),
                  child: LikeAnimation(
                      child: Icon(
                        Icons.favorite,
                        size: 100,
                      ),
                      isAnimating: isLikeAnimating,
                      onEnd: () {
                        setState(() {
                          isLikeAnimating = false;
                        });
                      }),
                )
              ]),
            ),

            // Likes, Comment Section
            Row(
              children: [
                LikeAnimation(
                  smallLike: true,
                  onEnd: () {},
                  isAnimating: widget.snap['Likes'].contains(user.uuid),
                  duration: Duration(milliseconds: 200),
                  child: IconButton(
                    onPressed: () async {
                      await Firestore().likePost(
                          likes: widget.snap['Likes'],
                          postId: widget.snap['postId'],
                          uuid: widget.snap['uid']);
                    },
                    icon: widget.snap['Likes'].contains(user.uuid)
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(Icons.favorite_outline),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.message_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark_border),
                    ),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.w700),
                      child: Text(
                        widget.snap['Likes'].length.toString() + ' Likes',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(height: 3),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: widget.snap['userName'],
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          TextSpan(text: '   ${widget.snap['description']}'),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentScreen(
                                    snap: widget.snap,
                                  )),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          commentLength == 0
                              ? 'Zero Comments'
                              : 'View all $commentLength comments',
                          style: TextStyle(color: secondaryColor),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 2),
                      child: Text(
                        DateFormat('dd-mm-yyyy')
                            .format(widget.snap['datePublished'].toDate())
                            .toString(),
                        style: TextStyle(color: secondaryColor),
                      ),
                    ),
                  ]),
            )
          ]),
    );
  }
}
