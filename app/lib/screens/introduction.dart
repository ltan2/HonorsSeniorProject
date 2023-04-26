import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<PageViewModel> pages = [
    PageViewModel(
      title: "Welcome",
      body: "Browse different worlds related to mental health themes",
      image: Center(child:Image.asset("allworld.PNG", height: 800, width: 550, fit: BoxFit.fill)),
      decoration: PageDecoration(
        pageColor: Colors.black,
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        titleTextStyle: TextStyle(fontSize: 28, color: Colors.white),
        bodyTextStyle: TextStyle(fontSize: 16, color: Colors.white),
        imagePadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),

      ),
    ),
    PageViewModel(
      title: "World",
      body: "Visit foods, location and activities in each world. Locations and activities features are designated actvities to help improve your mood. Explore now and collect rewards!",
      image: Image.asset("world.PNG", height: 600, width: 250),
      decoration: PageDecoration(
        pageColor: Colors.black,
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        titleTextStyle: TextStyle(fontSize: 28, color: Colors.white),
        bodyTextStyle: TextStyle(fontSize: 16, color: Colors.white),
        imagePadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      ),
    ),
    PageViewModel(
      title: "Get fit and pace yourself",
      body: "Stay fit and healthy by visiting our Exercise feature. When you reach a 20 minute limit using this app, you will be navigated to this page to help you break off time on screen and get moving",
      image: Image.asset("exercise.PNG", height: 600, width: 250),
      decoration: PageDecoration(
        pageColor: Colors.black,
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        titleTextStyle: TextStyle(fontSize: 28, color: Colors.white),
        bodyTextStyle: TextStyle(fontSize: 16, color: Colors.white),
        imagePadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      ),
    ),
    PageViewModel(
      title: "Points and rewards",
      body: "Visit the passport feature to view and redeem points you have collected!",
      image: Image.asset("passport.PNG", height: 600, width: 250),
      decoration: PageDecoration(
        pageColor: Colors.black,
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        titleTextStyle: TextStyle(fontSize: 28, color: Colors.white),
        bodyTextStyle: TextStyle(fontSize: 16, color: Colors.white),
        imagePadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      ),
    ),
    PageViewModel(
      title: "Connect with others",
      body: "Browse your friends feed and post one your own",
      image: Image.asset("feed.PNG", height: 600, width: 250),
      decoration: PageDecoration(
        pageColor: Colors.black,
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        titleTextStyle: TextStyle(fontSize: 28, color: Colors.white),
        bodyTextStyle: TextStyle(fontSize: 16, color: Colors.white),
        imagePadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      ),
    ),
    PageViewModel(
      title: "Journal along",
      body: "We encourage meditation practices as a way for you to focus on what is important in life. We recommend activities based on sentiment provided",
      image: Image.asset("journal.PNG", height: 600, width: 250),
      decoration: PageDecoration(
        pageColor: Colors.black,
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        titleTextStyle: TextStyle(fontSize: 28, color: Colors.white),
        bodyTextStyle: TextStyle(fontSize: 16, color: Colors.white),
        imagePadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      ),
    ),
    // Add more PageViewModel objects for additional pages
  ];

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: pages,
        onDone: () {
          Navigator.pushNamed(
          context,
          "/",
          );
          // Callback when done button is pressed
        },
        showNextButton: true,
        showSkipButton: true,
        skip: const Text("Skip"),
        next: const Text("Next"),
        done: const Text("Done"),
        dotsFlex: 2,
      ),
    );
  }
}