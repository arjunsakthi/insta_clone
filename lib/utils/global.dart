import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/screens/add_post_screen.dart';
import 'package:insta_clone/screens/feed_screen.dart';
import 'package:insta_clone/screens/profile_screen.dart';
import 'package:insta_clone/screens/search_screen.dart';

const webScreenSize = 600;
List<Widget> homeScreenItem = [
  FeedScreen(),
  SearchScreen(),
  AddPost(),
  Center(
    child: TextButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        child: Text('Log out')),
  ),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
