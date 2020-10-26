import 'package:aksestokomobile/helper/my_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:aksestokomobile/resource/my_decoration.dart';
import 'package:aksestokomobile/util/my_dimen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _changePage() async {
    await MyPref.init();
    var token = MyPref.getATToken();
    var isLogin = token != null && token.isNotEmpty;
    debugPrint('Aksestoko-Token $token');
    Future.delayed(Duration(seconds: MyDimen.timerSplash), () {
      debugPrint("=>>${MyPref.isIdDistributorExist()}");
      Get.offNamed(isLogin
          ? (MyPref.isIdDistributorExist()
              ? parentScreen
              : selectDistributorScreen)
          : loginScreen);
    });
  }

  @override
  void initState() {
    super.initState();
    _changePage();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: Container(
        decoration: MyDecoration.decorationGradient(),
        child: Stack(
          children: <Widget>[
            Center(
              child: Hero(
                tag: 'logoForcaPoS',
                child: MyLogo.logoForcaPoS(large: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
