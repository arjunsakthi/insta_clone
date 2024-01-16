import 'package:flutter/material.dart';
import 'package:insta_clone/model/user.dart';
import 'package:insta_clone/provider/user_provider.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/global.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  ResponsiveLayout({
    super.key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  });
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  bool userRefreshed = false;
  @override
  initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUsers();
    setState(() {
      userRefreshed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return userRefreshed
        ? LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > webScreenSize) {
                // returning webPage Widget
                return widget.webScreenLayout;
              }
              // returning mobile widget
              return widget.mobileScreenLayout;
            },
          )
        : Scaffold(
            body: Center(
              child: Container(
                width: MediaQuery.sizeOf(context).width / 1.5,
                height: MediaQuery.sizeOf(context).width / 1.5,
                child: CircularProgressIndicator(
                  color: primaryColor,
                  strokeWidth: 15,
                ),
              ),
            ),
          );
  }
}
