import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/resource/auth_method.dart';
import 'package:insta_clone/screens/signup_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/textfield_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passwd = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _passwd.dispose();
    super.dispose();
  }

  void userLogIn() async {
    setState(() {
      _isLoading = true;
    });
    final res = await AuthMehtods().LoginUser(_email.text, _passwd.text);
    if (res == 'Successfully Loged in') {
      showSnackBar(res, context);
    } else
      showSnackBar(res, context);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SvgPicture.asset('assets/ic_instagram.svg', color: primaryColor),
              SizedBox(
                height: 64,
              ),
              TextFieldInput(
                  textEditingController: _email,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Your email address'),
              SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwd,
                keyboardType: TextInputType.text,
                hintText: 'Your password',
                ispass: true,
              ),
              SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: userLogIn,
                child: Container(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: primaryColor,
                          ),
                        )
                      : Text("Log in"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text("Don't have an account ? "),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => SignupScreen(),
                        ),
                      );
                    },
                    child: Container(
                      child: Text(
                        "Sign up",
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
  }
}
