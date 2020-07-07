import 'package:flutter/material.dart';
import 'package:aksestokomobile/screen/account/update_profile_screen.dart';
import 'package:flutter/cupertino.dart';

abstract class UpdateProfileController extends State<UpdateProfileScreen>{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String email;
  String tlp;
}