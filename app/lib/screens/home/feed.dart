import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Feed extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
          initialUrl: "https://app.stage.so/projects/640f6a57154fd",
          javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}

