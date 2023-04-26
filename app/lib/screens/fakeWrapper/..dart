import 'package:flutter/material.dart';
import 'package:mobile_app/screens/auth/signin.dart';
import 'package:mobile_app/screens/auth/signup.dart';
import 'package:mobile_app/screens/main/posts/replies.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/screens/auth/auth_home.dart';
import 'package:mobile_app/screens/main/home.dart';
import 'package:mobile_app/screens/main/posts/add.dart';
import 'package:mobile_app/screens/main/profile/profile.dart';
import 'package:mobile_app/screens/main/profile/edit.dart';
import 'package:mobile_app/screens/main/exercise/exercise.dart';
import 'package:mobile_app/screens/main/mindful_game/map.dart';
import 'package:mobile_app/screens/main/mindful_game/game.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: FirebaseAuth.instance.authStateChanges().map((user) {
        if (user == null) {
          return null;
        } else {
          return _userFromFirebaseUser(user);
        }
      }),
      child: Consumer<UserModel?>(
        builder: (context, user, _) {
          if (user == null) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeData(
                primarySwatch: Colors.black,
                brightness: Brightness.dark,
              ),
              themeMode: ThemeMode.dark, 
              initialRoute: '/auth', routes: {
              '/auth': (context) => AuthPage(),
              '/signIn': (context) => SignIn(),
              '/signUp': (context) => SignUp(),
            });
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeData(
                brightness: Brightness.dark,
              ),
              themeMode: ThemeMode.dark, 
              initialRoute: '/', routes: {
              '/': (context) => Home(),
              '/add': (context) => Add(),
              '/profile': (context) => Profile(),
              '/edit': (context) => Edit(),
              '/replies': (context) => Replies(),
              '/exercise': (context) => Exercise(),
              '/passport': (context) => Passport(),
              '/mindfulness': (context) => MyWebView(),
            });
          }
        },
      ),
    );
  }
}
