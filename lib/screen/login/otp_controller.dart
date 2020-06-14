import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/login/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class RequestOtpController extends State<RequestOtpScreen>{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String otp;
}