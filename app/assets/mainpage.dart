
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/services/auth.dart';
import 'package:mobile_app/screens/home/home.dart';
import 'package:mobile_app/screens/home/search.dart';
import 'package:mobile_app/screens/home/feed.dart';
import 'package:mobile_app/screens/main/timer.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/services/user.dart';
import 'package:mobile_app/models/mood.dart';



class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);
  
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AuthService _authService = AuthService();
  UserService _userService = UserService();

  int _currentIndex = 0;
  final List<Widget> _children = [Feed(), Home(), Search()];

  LoginTimer _loginTimer = LoginTimer();

  @override
  void initState() {
    super.initState();
    _loginTimer.start(context);
  }
  
  void onTabPressed(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _loginTimer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed"),
        actions: [
          Container(
            width: 100,
            height: 50,
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/passport",
                );
              },
              icon: Row(
                children: [
                  Expanded(
                    child: Text("View points"),
                  ),
                  Icon(Icons.history),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          child: Icon(Icons.add)),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('drawer header'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile',
                    arguments: FirebaseAuth.instance.currentUser?.uid);
              },
            ),
            ListTile(
              title: Text('Personal feed'),
              onTap: () {
                Navigator.pushNamed(context, '/personalhome',
                    arguments: FirebaseAuth.instance.currentUser?.uid);
              },
            ),
            ListTile(
              title: Text('Passport'),
              onTap: () {
                Navigator.pushNamed(context, '/passport',
                    arguments: FirebaseAuth.instance.currentUser?.uid);
              },
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                Navigator.pushNamed(context, '/introduction',
                    arguments: FirebaseAuth.instance.currentUser?.uid);
              },
            ),
            ListTile(
              title: Text('Exercise'),
              onTap: () {
                Navigator.pushNamed(context, '/exercise',
                    arguments: FirebaseAuth.instance.currentUser?.uid);
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () async {
                await _authService.signOut();
                Navigator.pushNamed(context, "/signIn");
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabPressed,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: new Icon(Icons.feed), label: 'feed'),
          BottomNavigationBarItem(icon: new Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: new Icon(Icons.search), label: 'search')
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}