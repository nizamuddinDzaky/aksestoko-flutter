import 'dart:async';

import 'package:aksestokomobile/util/my_util.dart';
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
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  String url;
  String title;

  @override
  void initState() {
    var param = Get.arguments as Map<String, dynamic>;
    url = param['url'] as String;
    title = param['title'] as String ?? 'Web View';
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {}
    });
    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        if (!url.contains(RegExp('\baksestoko.*\b'))) {
          debugLogs([url, state.type == WebViewState.shouldStart, state.type]);
          flutterWebViewPlugin.goBack();
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _onUrlChanged?.cancel();
    _onStateChanged?.cancel();
    flutterWebViewPlugin?.dispose();
    super.dispose();
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
      ignoreSSLErrors: isDebugQA,
      withLocalStorage: true,
      withZoom: false,
      invalidUrlRegex: '\baksestoko.*\b',
    );
  }
}
