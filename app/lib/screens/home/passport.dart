import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Passport extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passport'),
      ),
      body: WebView(
        initialUrl: "https://app.stage.so/projects/6424752a12293",
        javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}
