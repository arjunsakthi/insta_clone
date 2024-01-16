import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/provider/user_provider.dart';
import 'package:insta_clone/responsive/mobile_screen_layout.dart';
import 'package:insta_clone/responsive/responsive_layout_screen.dart';
import 'package:insta_clone/responsive/web_screen_layout.dart';
import 'package:insta_clone/screens/login_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    print('object');
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCBZ7Vsx6qeI4Hfy65GD0kKBppea71swVQ",
        appId: "1:1034565538548:web:8bcec37876e5bbaa8c44a1",
        messagingSenderId: "1034565538548",
        projectId: "insta-clone-17-09",
        storageBucket: "insta-clone-17-09.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]).then(
  //   (value) => runApp(
  //     const MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapShot) {
            print('got one !!!!!!!!!!!!!!');
            if (snapShot.connectionState == ConnectionState.active) {
              print(snapShot.data);
              print(snapShot);
              if (snapShot.hasData) {
                print('in');
                return ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapShot.hasError) {
                return Center(
                  child: Text(snapShot.error.toString()),
                );
              }
            }
            if (snapShot.connectionState == ConnectionState.waiting) {
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
