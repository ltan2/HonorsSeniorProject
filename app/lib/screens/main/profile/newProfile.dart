import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/post.dart';
import 'package:mobile_app/screens/main/profile/recommend.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/models/favorite.dart';
import 'package:mobile_app/screens/main/posts/list.dart';
import 'package:mobile_app/screens/main/profile/favorites.dart';
import 'package:mobile_app/services/user.dart';
import 'package:mobile_app/services/posts.dart';

class ProfileHome extends StatefulWidget {
  final uid;
  ProfileHome(this.uid,{Key? key}) : super(key: key);

  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  UserService _userService = UserService();
  PostService _postService = PostService();
  String category = "Movies";
  List<String> categories = [
    "Movies",
    "Books",
    "Music"
  ];

  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<List<FavModel>>.value(
            initialData:[],
            value:_userService.getUserFav(widget.uid, category),
          ),
          StreamProvider<List<PostModel>>.value(
            initialData:[],
            value: _postService.getPostsByUser(widget.uid),
          ),
        ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black, 
            bottom: TabBar(
              indicatorColor: Color.fromRGBO(0, 0, 0, 1),
              labelColor: Colors.white,
              tabs: [
                Tab(text: 'Profile'),
                Tab(text: 'Favorites',),
                Tab(
                  text: 'Journal'),
              ],
            ),
            toolbarHeight: 0,
          ),
          body: TabBarView(
            children: [
            ListPosts(null),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: DropdownButton(
                    // Initial Value
                    value: category,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),   
                    // Array list of items
                    items: categories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      category =  newValue!;});
                    },
                  )
              ),
              Favorite(widget.uid, category),
            ]
            ),
            if (FirebaseAuth.instance.currentUser?.uid == widget.uid)
              Recommend(widget.uid)
            else if (FirebaseAuth.instance.currentUser?.uid != widget.uid)
              Text("You do not have permission to view")
            ],
          ),
        ),
      ),
    );
  }
}


