import 'dart:async';

import 'package:aksestokomobile/main_common.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen(this.url);

  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  String title;

  @override
  void initState() {
    var param = Get.arguments as Map<String, dynamic>;
    title = param['title'] as String ?? 'AksesToko';
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {}
    });
    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        var url = state?.url ?? '';
        if (!checkHost(url)) {
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
      url: widget.url,
      withJavascript: true,
      ignoreSSLErrors: isDebugQA,
      withLocalStorage: true,
      withZoom: false,
      invalidUrlRegex: '\baksestoko.*\b',
    );
  }
}
