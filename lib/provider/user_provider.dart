import 'package:flutter/material.dart';
import 'package:insta_clone/model/user.dart';
import 'package:insta_clone/resource/auth_method.dart';

class UserProvider with ChangeNotifier {
  user? _user;
  final _authMethods = AuthMehtods();

  user get getUser => _user!;

  Future<void> refreshUsers() async {
    _user = await _authMethods.getUserData();
    notifyListeners();
  }
}
