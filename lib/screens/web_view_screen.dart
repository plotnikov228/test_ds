import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final String url;
  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller = Completer<WebViewController>();
    return Scaffold(
        body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
    ),
      );
  }
}

