import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/screens/auth/signin.dart';
import 'package:mobile_app/screens/auth/signup.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key});


  @override
  _AuthPageState createState() =>  _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to sign in page
                Navigator.pushNamed(context,'/signIn');
              },
              child: Text('Sign In'),
            ),
            SizedBox(height: 16.0),
            OutlinedButton(
              onPressed: () {
                // Navigate to sign up page
                Navigator.pushNamed(context, '/signUp');
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
