import 'package:flutter/material.dart';
import 'package:aksestokomobile/screen/account/change_password_screen.dart';

abstract class ChangePasswordController extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String oldPassword;
  String newPassword;
  String repeatPassword;

  var isOldPassword = false;
  var isNewPassword = false;
  var isRepeatPassword = false;
}