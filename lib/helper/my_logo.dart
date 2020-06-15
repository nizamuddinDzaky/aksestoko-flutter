import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/material.dart';

class MyLogo {
  static Widget logoForcaPoS({large = false}) {
    return Image.asset(
      kLogoAT,
      width: large ? 200 : 120,
      height: large ? null : 56,
      color: Colors.white,
      fit: BoxFit.cover,
    );
  }

  static Widget logoATWhite({double width, double height}) {
    return Image.asset(
      kLogoAT,
      width: width,
      height: height,
      color: Colors.white,
      fit: BoxFit.cover,
    );
  }


  static Widget logoForcaPoSColor({double width, double height}) {
    return Image.asset(
      kLogoAT,
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }

  static Widget forgotPassword() {
    return Image.asset(
      kForgotPassword,
      fit: BoxFit.cover,
    );
  }
}
