import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl ='https://land.05rg.com/';

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse(homeUrl));
  
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Link2me Site'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.loadRequest( Uri.parse(homeUrl));
              },
              icon: Icon(
                Icons.home,
              ))
        ],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
