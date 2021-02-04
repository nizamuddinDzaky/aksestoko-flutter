
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';

import '../../main_common.dart';

class WebViewScreen extends StatefulWidget {
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  StreamSubscription<String> _onUrlChanged;
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  String url;
  String title = "Web View";
  @override
  void initState() {
    var param = Get.arguments as Map<String, dynamic>;
    url = param['url'] as String;
    title = param['title'] as String;
    /*urlKreditPro = param['urlKreditPro'] as String;
    idPurchase = param['idPurchase'] as String;*/
    // TODO: implement initState
    debugPrint("url : $url");
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      /*if (mounted) {
        if (url.contains("success_kreditpro#")) {
          Get.offNamedUntil(
            detailOrderScreen,
                (route) => route.settings.name == parentScreen,
            arguments: idPurchase,
          );
        }
      }*/
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(title),
          backgroundColor: Colors.black,
      ),
      url: url,
      withJavascript: true,
      ignoreSSLErrors: isDebugQA ? true : false,
      withLocalStorage: true,
      withZoom: false,
      /*javascriptChannels: ,*/

    );
  }
}