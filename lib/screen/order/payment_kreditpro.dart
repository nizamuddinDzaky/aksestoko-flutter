import 'dart:async';

import 'package:aksestokomobile/app/my_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
/*import 'package:webview_flutter/webview_flutter.dart';*/

class PaymentKreditproScreen extends StatefulWidget {
  _PaymentKreditproScreenState createState() => _PaymentKreditproScreenState();
}

class _PaymentKreditproScreenState extends State<PaymentKreditproScreen> {

  StreamSubscription<String> _onUrlChanged;
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  String urlKreditPro;
  String idPurchase;
  @override
  void initState() {
    var param = Get.arguments as Map<String, dynamic>;
    urlKreditPro = param['urlKreditPro'] as String;
    idPurchase = param['idPurchase'] as String;
    // TODO: implement initState
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {

      if (mounted) {
        if(url.contains("success_kreditPro")){
          Get.offNamedUntil(
            detailOrderScreen,
                (route) => route.settings.name == parentScreen,
            arguments: idPurchase,
          );
        }
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Kredit Pro"),
      ),
      url: urlKreditPro,
      withJavascript: true,
      withLocalStorage: true,
      withZoom: false,

    );
  }

}