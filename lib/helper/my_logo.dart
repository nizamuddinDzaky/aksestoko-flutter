import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/material.dart';

class MyLogo {
  static Widget logoForcaPoS({large = false}) {
    return Image.asset(
      kLogoForcaPoS,
      width: large ? 200 : 120,
      height: large ? null : 56,
      color: Colors.white,
      fit: BoxFit.cover,
    );
  }

  static Widget logoForcaPoSColor({double width, double height}) {
    return Image.asset(
      kLogoForcaPoS,
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
