import 'package:flutter/material.dart';
import 'package:mobile_app/services/auth.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);


  @override
  _SignInState createState() =>  _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  String email = "";
  String password = "";
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 8,
        title: Text("Sign In")
      ),
      body: Center(
        child: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        // ignore: unnecessary_new
        child: new Form(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                onChanged: (val) => setState(() {
                  email = val;
                }),
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              TextFormField(
                onChanged: (val) => setState(() {
                  password = val;
                }),
                obscureText: _isObscured,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    child: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0, // height you want
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text("Sign In"),
                    onPressed: () async {
                      // Perform sign-in logic here
                      await _authService.signIn(email, password);
                      // Sign-in successful, navigate back to Wrapper widget
                      Navigator.pushNamed(context, "/introduction");
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text("Dont have an account? Sign Up now!"),
                    onPressed: () async {
                     Navigator.popAndPushNamed(context, "/signUp");
                    },
                  ),
                ]
              )
            ]
          ))
      )
    ));
  }
}