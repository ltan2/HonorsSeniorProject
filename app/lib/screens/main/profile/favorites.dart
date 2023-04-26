import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/models/favorite.dart';
import 'package:mobile_app/screens/main/profile/favForm.dart';


class Favorite extends StatefulWidget {
  final uid;
  final Category;
  Favorite(this.uid, this.Category, {Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool isEdit = false;
  stillEditing(newState) {
    setState(() {
      isEdit = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favs = Provider.of<List<FavModel>>(context);
    return SingleChildScrollView(
      child:Column(
      children: [
        isEdit ? Text(""):
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  isEdit = true;
                });
              },
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isEdit = true;
                });
              },
              child: new Text("Add a new favorite"),
            )
          ]
        ),
        isEdit ?
          FavForm(widget.uid, stillEditing)
          : Text(""),
        isEdit? 
          Container(): 
          ListView.builder(
            shrinkWrap: true,
            itemCount: favs.length,
            itemBuilder: (context, index) {
            final fav_item = favs[index];
            if(widget.Category == "Movies"){
              String genre = 'Genre: ${fav_item.interest}';
              return SingleChildScrollView(
                child: Card(
                child: Column(
                children: <Widget>[
                  ListTile(
                  leading: Icon(Icons.movie, size: 40),
                  title: Text(fav_item.name),
                  subtitle: Text(genre),
                ),
                Text(fav_item.description ?? "")]
              )));
            }
            else if(widget.Category == "Books"){
              String genre = 'Genre: ${fav_item.interest}';
              return Card(
                child: Column(
                children: <Widget>[
                  ListTile(
                  leading: Icon(Icons.book, size: 40),
                  title: Text(fav_item.name),
                  subtitle: Text(genre),
                ),
                Text(fav_item.description ?? "")]
              ));
            }
            else{
              String genre = 'Genre: ${fav_item.interest}';
              return Card(
                child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.music_note, size: 40),
                    title: Text(fav_item.name),
                    subtitle: Text(genre),
                  ),
                  Text(fav_item.description ?? "")]
                )
              );
            }
          },
        )
      ]
    ));
  }
}
