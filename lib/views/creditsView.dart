import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreditsRoute extends StatefulWidget {
  const CreditsRoute({Key? key}) : super(key: key);

  @override
  _CreditsRouteState createState() => _CreditsRouteState();
}

class WebViewLoadUI extends State<WebViewLoad> {
  late WebViewController webViewController;
  String htmlFilePath = 'assets/html/credits.html';

  loadLocalHTML() async {
    String fileHtmlContents = await rootBundle.loadString(htmlFilePath);
    webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController tmp) {
          webViewController = tmp;
          loadLocalHTML();
        });
  }
}

class WebViewLoad extends StatefulWidget {
  const WebViewLoad({Key? key}) : super(key: key);

  @override
  WebViewLoadUI createState() => WebViewLoadUI();
}

class _CreditsRouteState extends State<CreditsRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Credits"),
      ),
      body: const WebViewLoad(),
    );
  }
}
