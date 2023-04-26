import 'package:mobile_app/screens/auth/signin.dart';
import 'package:mobile_app/screens/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/services/auth.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  _SignUpState createState() =>  _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _authService = AuthService();

  String email = "";
  String password = "";
  String c_password = "";
  bool _isObscured = true;
  bool _isObscured2 = true;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 8,
        title: Text("Sign Up")
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
              TextFormField(
                onChanged: (val) => setState(() {
                  c_password = val;
                  isError = password != c_password;
                }),
                obscureText: _isObscured2,
                decoration: InputDecoration(
                  labelText: 'Confirm password',
                  hintText: 'Enter your password again',
                  errorText: isError ? 'Passwords do not match' : null,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isObscured2 = !_isObscured2;
                      });
                    },
                    child: Icon(
                      _isObscured2 ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0, // height you want
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text("Sign Up"),
                    onPressed: () async => {
                      if(c_password != password){
                        setState(() {
                          isError = true;
                        }),
                      }
                      else{
                        _authService.signUp(email, password),
                        Navigator.popAndPushNamed(context, "/introduction")
                      }
                    }
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text("Have an account? Sign In now!"),
                    onPressed: () async {
                     Navigator.popAndPushNamed(context, "/signIn");
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