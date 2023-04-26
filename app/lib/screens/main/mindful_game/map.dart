import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find other players"),
      ),
      body: WebView(
        initialUrl: "https://goo.gl/maps/3wWRioHehbkJrJd89",
        javascriptMode: JavascriptMode.unrestricted,
      ));
  }
}
