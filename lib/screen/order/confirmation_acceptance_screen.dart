import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ConfirmationAcceptScreen extends StatefulWidget {
  _ConfirmationAcceptScreen createState() => _ConfirmationAcceptScreen();
}

class _ConfirmationAcceptScreen extends State<ConfirmationAcceptScreen> {
  File imageFile;

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
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

  @override
  Widget build(BuildContext context) {
    var formLayout = SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 25, left: 25, right: 25),
              child: Text(
                "SALE/AT/2020/06/07",
                style: TextStyle(
                    color: MyColor.blackTextAT,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: MyColor.greyTextAT,
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: Offset(0, 2), // changes position of shadow
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "No SPJ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "DO/2020/06/0023",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.greyTextAT),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Status Pengiriman",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Dalam Pengiriman",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.infoAT),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Tanggal Dikirim",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "05 Juni 2020",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.greyTextAT),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Dikirim Oleh",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "-",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.greyTextAT),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Barang Diterima",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          ListProductShipment(),
                          ListProductShipment(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              child: Text(
                                "Catatan",
                                style: TextStyle(
                                    color: MyColor.blackTextAT,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          maxLength: 1000,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffEEEEEE),
                            hintText: "Catatan",
                            contentPadding:
                                const EdgeInsets.only(left: 20, top: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffC8C8C8), width: 2.0),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                                topLeft: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyColor.redAT, width: 1),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                                topLeft: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Unggah SPJ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
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
                              _decideImageView(),
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
                ],
              ),
            ),
            Container(
              height: 3,
              color: Color(0xffEAEAEA),
              margin: EdgeInsets.symmetric(vertical: 30),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25, left: 25, right: 25),
              child: Text(
                "Ringkasan",
                style: TextStyle(
                    color: MyColor.blackTextAT,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: MyColor.greyTextAT,
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: Offset(0, 2), // changes position of shadow
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Jumlah Baik",
                              style: TextStyle(
                                  fontSize: 16, color: MyColor.greyTextAT),
                            ),
                            Text(
                              "2",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Jumlah Rusak",
                              style: TextStyle(
                                  fontSize: 16, color: MyColor.greyTextAT),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Jumlah Barang",
                              style: TextStyle(
                                fontSize: 16,
                                color: MyColor.greyTextAT,
                              ),
                            ),
                            Text(
                              "2",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 3,
              color: Color(0xffEAEAEA),
              margin: EdgeInsets.symmetric(vertical: 30),
            ),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: MyColor.greenAT,
                borderRadius: BorderRadius.circular(30),
              ),
              child: FlatButton(
                child: Text(
                  "Terima Barang",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: null,
              ),
            ),
          ],
        ),
      ),
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
            "Konfrimasi Penerimaan",
            style: TextStyle(fontSize: 20),
          ),
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  print('klik notif');
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

  Widget ListProductShipment() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: MyColor.greyTextAT,
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 2), // changes position of shadow
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: MyColor.redAT,
                ),
                child: Text(
                  "S",
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "SEMEN PCC ZAK 40KG",
                      style: TextStyle(
                          color: MyColor.redAT,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "121-030-0050",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                    Row(
                      children: <Widget>[
                        Text(
                          "100",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                        Padding(padding: EdgeInsets.only(left: 4)),
                        Text(
                          "SAK",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 3,
            color: Color(0xffEAEAEA),
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Barang Baik"),
                    Padding(padding: EdgeInsets.all(5)),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffEEEEEE),
                        hintText: "100",
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
              ),
              Padding(padding: EdgeInsets.all(10)),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Barang Rusak"),
                    Padding(padding: EdgeInsets.all(5)),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffEEEEEE),
                        hintText: "100",
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
