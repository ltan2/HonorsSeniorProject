import 'dart:async';
import 'package:mobile_app/services/auth.dart';
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class LoginTimer {
  Timer ? _timer1;
  Timer ? _timer2;
  final AuthService _authService = AuthService();


  void start(context) {
    _timer1 = Timer(Duration(seconds: 600), () {
      _authService.signOut();
    });
    _timer2 = Timer(Duration(seconds: 400), () {
      Navigator.pushNamed(context, '/exercise');
    });
  }

  void stop() {
    if (_timer1 != null) {
      _timer1?.cancel();
    }
    if (_timer2 != null) {
      _timer1?.cancel();
    }
  }

}
