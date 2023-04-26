import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/models/favorite.dart';
import 'package:mobile_app/services/user.dart';

class FavForm extends StatefulWidget {
  final uid;
  final edit;
  FavForm(this.uid, this.edit, {Key? key}) : super(key: key);

  @override
  _FavFormState createState() => _FavFormState();
}

class _FavFormState extends State<FavForm> {
  UserService _userService = UserService();
  String name = "";
  String interest = "";
  String des = "";
  String category = "Movies";
  bool isEdit = false;
  List<String> categories = [
    "Movies",
    "Books",
    "Music"
  ];
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      // ignore: unnecessary_new
      child: new Form(
        child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                widget.edit(false);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Title",
              ),
              onChanged: (val) => setState(() {
                name = val;
              }),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Genre",
              ),
              onChanged: (val) => setState(() {
                interest = val;
              }),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Description",
              ),
              onChanged: (val) => setState(() {
                des = val;
              }),
            ),
            const SizedBox(
              height: 5.0, // height you want
            ),
            DropdownButton(
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
                  category =  newValue!;
                });
              },
            ),
            ElevatedButton(
              child: Text("Save"),
              onPressed: () async => {
                _userService.saveFav(widget.uid, category, name, interest, des),
                widget.edit(false)
              }
            )
          ]
        )
      )
    );
  }
}