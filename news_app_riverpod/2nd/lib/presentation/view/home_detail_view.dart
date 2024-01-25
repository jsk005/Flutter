import 'package:flutter/material.dart';
import 'dart:core';
import 'package:webview_flutter/webview_flutter.dart';

class HomeDetailView extends StatelessWidget {
  final String Url_path;

  HomeDetailView({
    Key? key,
    required this.Url_path,
  }) : super(key: key);

  //WebViewController? controller;
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.blueGrey.shade100)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (progress) {},
        onPageStarted: (url) {},
        onPageFinished: (url) {},
        onWebResourceError: (error) {},
        onNavigationRequest: (request) {
          if (request.url.startsWith('url')) {
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   body: WebView(
      //     onWebViewCreated: (WebViewController controller) {
      //       this.controller = controller;
      //     },
      //     initialUrl: Url_path,
      //     javascriptMode: JavascriptMode.unrestricted,
      //   ),
      body: WebViewWidget(
        controller: controller..loadRequest(Uri.parse(Url_path)),
      ),
    );
  }
}
