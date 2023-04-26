import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/screens/auth/signin.dart';
import 'package:mobile_app/screens/auth/signup.dart';
import 'package:mobile_app/screens/home/home.dart';
import 'package:mobile_app/screens/home/passport.dart';
import 'package:mobile_app/screens/home/personalHome.dart';
import 'package:mobile_app/screens/introduction.dart';
import 'package:mobile_app/screens/main/exercise/exercise_tracker.dart';
import 'package:mobile_app/screens/main/posts/replies.dart';
import 'package:mobile_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/screens/auth/auth_home.dart';
import '../../assets/mainpage.dart';
import 'package:mobile_app/screens/main/posts/add.dart';
import 'package:mobile_app/screens/main/profile/profile.dart';
import 'package:mobile_app/screens/main/profile/edit.dart';
import 'package:mobile_app/screens/main/exercise/exercise.dart';
import 'package:mobile_app/screens/main/mindful_game/map.dart';
import 'package:mobile_app/screens/main/mindful_game/game.dart';


class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: _authService.user,
      initialData: null, // set initial data to null
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        routes: {
            '/': (context) => Builder(
              builder: (context) {
                final user = Provider.of<UserModel?>(context);
                return user == null ? AuthPage() : MainPage();
              },
            ),
            '/signIn': (context)  => Builder(
              builder: (context) {
                final user = Provider.of<UserModel?>(context);
                return user == null ? SignIn() : MainPage();
              },
            ),
            '/signUp': (context) => SignUp(),
            '/introduction': (context) => IntroScreen(),
            '/add': (context) => Builder(
              builder: (context) {
                final user = Provider.of<UserModel?>(context);
                return user == null ? AuthPage() : Add();
              },
            ),
            '/profile': (context) => Builder(
              builder: (context) {
                final user = Provider.of<UserModel?>(context);
                return user == null ? AuthPage() : Profile();
              },
            ),
            '/edit': (context) => Builder(
              builder: (context) {
                final user = Provider.of<UserModel?>(context);
                return user == null ? AuthPage() : Edit();
              },
            ),
            '/replies': (context) => Builder(
              builder: (context) {
                final user = Provider.of<UserModel?>(context);
                return user == null ? AuthPage() : Replies();
              },
            ),
            '/passport': (context) => Builder(
              builder: (context) {
                final user = Provider.of<UserModel?>(context);
                return user == null ? AuthPage() : Passport();
              },
            ),
            '/exercise': (context) => Builder(
              builder: (context) {
                final user = Provider.of<UserModel?>(context);
                return user == null ? AuthPage() : Exercise();
              },
            ),
            '/mindfulness': (context) => Builder(
              builder: (context) {
                final user = Provider.of<UserModel?>(context);
                return user == null ? AuthPage() : MyWebView();
              },
            ),
            '/personalhome': (context) => Builder(
              builder: (context) {
                final user = Provider.of<UserModel?>(context);
                return user == null ? AuthPage() : PHome();
              },
            ),
            '/tracker': (context) => Builder(
              builder: (context) {
                final user = Provider.of<UserModel?>(context);
                return user == null ? AuthPage() : Tracker();
              },
            ),
        }
      )
    );
  }
}