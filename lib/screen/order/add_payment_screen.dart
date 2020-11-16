import 'dart:convert';
import 'dart:io';
import 'package:clipboard/clipboard.dart';
import 'package:aksestokomobile/helper/my_divider.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:aksestokomobile/view_model/order/add_payment_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;

class AddPaymentScreen extends StatefulWidget {
  _AddPaymentScreenState createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends AddPaymentViewModel {

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text(
        "Belum ada gambar terpilih",
        style:
        TextStyle(color: MyColor.greyTextAT, fontStyle: FontStyle.italic),
      );
    } else {
      return Image.file(
        imageFile,
        width: 200,
        height: 200,
      );
    }
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    final bytes = Io.File(picture.path).readAsBytesSync();
    base64File += base64Encode(bytes);
    // var decode = base64.decode(base64File);
    /*debugPrint('decode : ${base64File}');*/
    this.setState(() {
      imageFile = File(picture.path);
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.camera);
    final bytes = Io.File(picture.path).readAsBytesSync();
    base64File += base64Encode(bytes);
    this.setState(() {
      imageFile = File(picture.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Silahkan Pilih"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    nominalTextController.text ='';
    idPemesanan = Get.arguments?.toString();
    actionRefresh();
  }

  @override
  Widget build(BuildContext context) {
    var formLayout =
    completeLoad == null
        ? Center(child: CircularProgressIndicator()) :
    SingleChildScrollView(
      child:Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 3,
                    color: Color(0xffEAEAEA),
                    margin: EdgeInsets.only(top: 5, bottom: 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Image.asset(
                              paymentIcon(paymentData != null ? paymentData.metodePembayaran : ""),
                              width: 18,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                            ),
                            child: Text(
                              paymentMethode(paymentData != null ? paymentData.metodePembayaran : ""),
                              style: TextStyle(
                                  color: MyColor.blackTextAT,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Text(
                              paymentData != null ? paymentData.harga : "",
                              style: TextStyle(
                                  color: MyColor.redAT,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          if(paymentData != null)
                            if(paymentData.showPelunasan)
                              Container(
                                margin: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                ),
                                child: Text(
                                  "(${paymentData != null ? paymentData.durasiPembayaran : " "})",
                                  style: TextStyle(
                                      color: MyColor.redAT,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ),
                              ),
                        ],
                      ),

                      /*Container(
                      color: Color(0xffEAEAEA),
                      margin: EdgeInsets.only(top: 10, bottom: 10, left: 0),
                      child:
                    ),*/

                    ],
                  ),

                  Container(
                    height: 3,
                    color: Color(0xffEAEAEA),
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: MyColor.redAT,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                paymentData != null ? paymentData.melalui : "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ]
                      )
                  ),
                  if(paymentData != null)
                    if(paymentData.showDetailBank)
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Nomor Rekening Tujuan",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColor.greyTextAT,
                                      fontSize: 16),
                                ),
                                MyDivider.spaceDividerElementsAT(custom: 5),
                                Text(
                                  paymentData != null ? paymentData.rekening : "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColor.blackTextAT,
                                      fontSize: 16),
                                ),
                                MyDivider.spaceDividerElementsAT(custom: 5),
                                Text(
                                  "a/n ${paymentData != null ? paymentData.atasNama : ""}",
                                  style: TextStyle(
                                      color: MyColor.blackTextAT,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            FadeInImage.assetNetwork(
                              placeholder: kDistributor,
                              image: MyString.BASE_PATH_ICON_BANK+paymentData.logo,
                              /*fit: BoxFit.cover,*/
                              height: 100,
                              width: 150,
                            ),
                            /*Image.asset(
                          atBankExample,
                          width: 120,
                        ),*/
                          ],
                        ),
                      ),

                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 5, bottom: 10),
                        child: Text(
                          "Detail",
                          style: TextStyle(
                              color: MyColor.blackTextAT,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: MyColor.greyTextAT,
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset:
                          Offset(0, 2), // changes position of shadow
                        )
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        if(paymentData != null)
                          if(paymentData.harga != null && paymentData.harga != 0)
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Harga",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColor.greyTextAT),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      paymentData != null ? paymentData.harga : "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColor.blackTextAT,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        if(paymentData != null)
                          if(paymentData.diskon != null && paymentData.diskon != 0)
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Diskon",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColor.greyTextAT),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      paymentData != null ? paymentData.diskon : "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColor.blackTextAT,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        if(paymentData != null)
                          if(paymentData.biaya != null && paymentData.biaya != 0)
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      paymentData != null ? paymentData.textBiaya : "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColor.greyTextAT),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      paymentData != null ? paymentData.biaya : "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: statusColor(paymentData != null ? paymentData.labelBiaya : ""),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        if(paymentData != null)
                        // ignore: unrelated_type_equality_checks
                          if(paymentData.telahDibayar != null && paymentData.telahDibayar != 0)
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Sudah Dibayar",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColor.greyTextAT),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      paymentData != null ? paymentData.telahDibayar : "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColor.greenAT,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        Container(
                          height: 3,
                          color: Color(0xffEAEAEA),
                          margin: EdgeInsets.only(top: 10, bottom: 20),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Yang Perlu Dibayar",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: MyColor.greyTextAT,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      paymentData != null ? paymentData.total : "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColor.redAT,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Material(
                                      child: InkWell(
                                        onTap: () {
                                          FlutterClipboard.copy(paymentData.total.replaceAll("Rp", "").replaceAll(",", "").trim());
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: ClipRRect(
                                            /*borderRadius: BorderRadius.circular(20.0),*/
                                            child: Icon(Icons.copy, size: 18) ,
                                          ),),
                                      )
                                  )
                                  /*Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: ClipRRect(
                                      child:
                                    )
                                    *//*,*//*
                                  ),*/
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  MyDivider.spaceDividerElementsAT(custom: 10),
                  if(paymentData != null)
                    if(paymentData.showPelunasan)
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Rencana Pelunasan",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MyColor.blackTextAT,
                                  fontSize: 16),
                            ),
                            Text(
                              "Hanya sebagai pengingat Toko",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: MyColor.blackTextAT,
                                  fontSize: 14),
                            ),
                            Text(
                              "tidak berimbas menjadi batas pembayaran Toko",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: MyColor.blackTextAT,
                                  fontSize: 14),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: MyColor.redAT,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                paymentData != null ? paymentData.durasiPembayaran : "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    padding: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: MyColor.greyTextAT),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
//                      color: Color(0xfff5f5f5),
//                      borderRadius: BorderRadius.circular(5),
//                            border: Border(
//                              bottom: BorderSide(width: 1, color: MyColor.greyTextAT,),
//                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              _decideImageView()
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 25, right: 25),
                          width: double.maxFinite,
                          height: 40,
                          decoration: BoxDecoration(
                            color: MyColor.redAT,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                Padding(padding: EdgeInsets.only(right: 5)),
                                Text(
                                  "Pilih File",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            onPressed: () {
                              _showChoiceDialog(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: MyColor.greyTextAT,
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset:
                          Offset(0, 2), // changes position of shadow
                        )
                      ],
                    ),
                    child: Row(
                      children: <Widget>[

                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Nominal"),
                              Padding(padding: EdgeInsets.all(5)),
                              TextField(
                                controller: nominalTextController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  hintText: paymentData != null ? paymentData.total : "",
                                  contentPadding: const EdgeInsets.only(left: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffC8C8C8), width: 1.0),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(5.0),
                                      bottomRight: Radius.circular(5.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: MyColor.redAT, width: 1),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(5.0),
                                      bottomRight: Radius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  /*if (CashBeforeDelivery)*/
                  MyDivider.spaceDividerElementsAT(custom: 10),
                  /*if (CashBeforeDelivery)*/
                  Container(
                    width: double.maxFinite,
                    child: Row(
                      /*mainAxisAlignment: MainAxisAlignment.center,*/
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: MyColor.greenAT,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: FlatButton(
                            child: Text(
                              "Unggah Bukti Pembayaran",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            onPressed: () {
                              actionAddPayment();
                              /*Get.toNamed(successScreen);*/
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Container(
            height: 3,
            color: Color(0xffEAEAEA),
            margin: EdgeInsets.only(top: 20, bottom: 20),
          ),
        ],
      )
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        title: Container(
          //color: Colors.white,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Text(
            "Pembayaran",
            style: TextStyle(fontSize: 20),
          ),
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  debugPrint('klik notif');
                },
              ),
              Positioned(
                right: 5,
                top: 4,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: MyColor.redAT,
                  child: Text(
                    '20',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: formLayout,
      ),
    );
  }
}