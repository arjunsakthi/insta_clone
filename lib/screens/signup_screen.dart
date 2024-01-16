import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/resource/auth_method.dart';
import 'package:insta_clone/responsive/mobile_screen_layout.dart';
import 'package:insta_clone/responsive/responsive_layout_screen.dart';
import 'package:insta_clone/screens/login_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/textfield_input.dart';

import '../responsive/web_screen_layout.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passwd = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  @override
  void dispose() {
    _email.dispose();
    _passwd.dispose();
    _username.dispose();
    _bio.dispose();
    super.dispose();
  }

  void _imagePick() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void userSignUp() async {
    String res = '';
    setState(() {
      _isLoading = true;
    });
    try {
      res = await AuthMehtods().signUpUser(
        username: _username.text,
        email: _email.text,
        password: _passwd.text,
        bio: _bio.text,
        file: _image!,
      );
      // .timeout(
      //   Duration(seconds: 5),
      // );

      if (res != 'Successfully Registered') {
        showSnackBar(res, context);
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ));
      }
    } on TimeoutException catch (e) {
      showSnackBar('Time Out ...', context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // for keyboard to overlap widgets
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // insta svg image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
              ),
              SizedBox(
                height: 15,
              ),
              // circular widget to accept and show our selected file
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: AssetImage('assets/profile.webp'),
                        ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: IconButton(
                      onPressed: _imagePick,
                      icon: Icon(Icons.add_a_photo_outlined),
                      iconSize: 30,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              // text input for username
              TextFieldInput(
                textEditingController: _username,
                keyboardType: TextInputType.text,
                hintText: 'Your username',
              ),
              SizedBox(
                height: 24,
              ),
              // text input for email address

              TextFieldInput(
                  textEditingController: _email,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Your email address'),
              SizedBox(
                height: 24,
              ),
              // text input for password

              TextFieldInput(
                textEditingController: _passwd,
                keyboardType: TextInputType.text,
                hintText: 'Your password',
                ispass: true,
              ),
              SizedBox(
                height: 24,
              ),
              // text input for bio

              TextFieldInput(
                textEditingController: _bio,
                keyboardType: TextInputType.text,
                hintText: 'Your Bio',
              ),
              SizedBox(
                height: 24,
              ),
              // container for login button
              InkWell(
                onTap: userSignUp,
                child: Container(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: primaryColor,
                          ),
                        )
                      : Text("sign up"),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // container for login button

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text("Already have an account ? "),
                  ),
                  // for sign up
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Container(
                      child: Text(
                        "Login in",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
