import 'package:flutter/material.dart';
import 'package:mobile_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/screens/main/profile/list.dart';
import 'package:mobile_app/services/user.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String search = '';
  @override
  Widget build(BuildContext context) {
    UserService _userService = UserService();
    
    return StreamProvider<List<UserModel>>.value(
      value: _userService.queryByName(search),
      initialData: [],
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  search = text;
                });
              },
              decoration: InputDecoration(hintText: 'Search...'),
            ),
          ),
          ListUsers()
        ],
      ),
    );
  }
}