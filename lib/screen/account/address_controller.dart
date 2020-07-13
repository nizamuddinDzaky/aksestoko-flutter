import 'package:flutter/material.dart';
import 'package:aksestokomobile/screen/account/add_address_screen.dart';
import 'package:flutter/cupertino.dart';

abstract class AddAddressController extends State<AddAddressScreen>{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String recipientsName;
  String email;
  String tlp;
  String address;
  String postalCode;

  String selectProvince = "";
  String selectDistrict = "";
  String selectSubDistrict = "";
  String selectVillage = "";

  final provinceSelected  = TextEditingController();
  List<String> province = [
    "Jawa Timur",
    "Jawa Tengah",
  ];

  final districtSelected  = TextEditingController();
  List<String> district = [
    "Ponorogo",
    "Surabaya",
  ];

  final subDistrictSelected  = TextEditingController();
  List<String> subDistrict = [
    "Nama Kecamatan Satu",
    "Nama Kecamatan Dua",
  ];

  final villageSelected  = TextEditingController();
  List<String> village = [
    "Nama Desa Satu",
    "Nama Desa Dua",
  ];

}