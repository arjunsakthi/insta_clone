import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/model/user.dart';
import 'package:insta_clone/provider/user_provider.dart';
import 'package:insta_clone/screens/add_post_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/global.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 4;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 4);
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // for checking how streaming works
    // Timer(Duration(seconds: 5), () {
    //   FirebaseAuth.instance.signOut();
    // });

    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: onPageChanged,
            physics: const NeverScrollableScrollPhysics(),
            children: homeScreenItem,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: mobileBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: mobileBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outlined,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: mobileBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: mobileBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: mobileBackgroundColor,
          ),
        ],
        iconSize: 30,
        onTap: navigationTapped,
      ),
    );
  }
}
