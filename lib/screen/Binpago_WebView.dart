import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constant.dart';

class BinpagoWebView extends StatefulWidget {
  const BinpagoWebView({Key? key}) : super(key: key);

  @override
  _BinpagoWebViewState createState() => _BinpagoWebViewState();
}

class _BinpagoWebViewState extends State<BinpagoWebView> {
  bool isLoading = true;
  String url = 'https://ialy1595.me/kouku/';
  late WebViewController _webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '쿠크세이튼 빙고 도우미',
            style: contentStyle.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          elevation: .5,
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _goBack(context);
              },
              color: Colors.black,
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  isLoading = true;
                  _webViewController.reload();
                });
              },
              color: Colors.black,
            ),
          ]),
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: Stack(children: [
              WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Stack(),
            ]),
          );
        },
      ),
    );
  }
  Future<bool> _goBack(BuildContext context) async{
    if(await _webViewController.canGoBack()){
      _webViewController.goBack();
      return Future.value(false);
    }else{
      return Future.value(true);
    }
  }
}
