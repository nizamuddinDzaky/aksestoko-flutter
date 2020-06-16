import 'package:aksestokomobile/screen/home/home_screen.dart';
import 'package:aksestokomobile/screen/home/select_distributor.dart';
import 'package:aksestokomobile/screen/home/select_product.dart';
import 'package:aksestokomobile/screen/login/forgot_password_screen.dart';
import 'package:aksestokomobile/screen/login/login_screen.dart';
import 'package:aksestokomobile/screen/login/register_screen.dart';
import 'package:aksestokomobile/screen/login/otp_screen.dart';
import 'package:aksestokomobile/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String root = "/";
const loginScreen = "/LoginScreen";
const registerScreen = "/RegisterScreen";
const forgotPasswordScreen = "/ForgotPasswordScreen";
const homeScreen = "/HomeScreen";
const requestOtpScreen = "/RequestOtpScreen";
const selectDistributorScreen = "/SelectDistributorScreen";
const selectProductScreen = "/SelectProductScreen";

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return GetRouteBase(
          page: SplashScreen(),
          settings: settings,
        );
      case selectProductScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: SelectProductScreen(),
        );
      case loginScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: LoginScreen(),
        );
      case selectDistributorScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: SelectDistributorScreen(),
        );
      case registerScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: RegisterScreen(),
        );
      case forgotPasswordScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: ForgotPasswordScreen(),
        );
      case requestOtpScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: RequestOtpScreen(),
        );
      case homeScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: HomeScreen(),
        );
      default:
        return GetRouteBase(
            settings: settings,
            transition: Transition.fade,
            page: Scaffold(
              body:
              Center(child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}