import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/helper/my_divider.dart';
import 'package:flutter/services.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  String selectShipping = "";
  final shipingSelected = TextEditingController();

  List<String> shiping = [
    "Pengiriman Distributor",
    "Pengambilan Sendiri",
  ];

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _date) {
      print("Date Selected: ${_date.toString()}");
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var formLayout = SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 15,
                    ),
                    child: Text(
                      "Alamat Pengiriman",
                      style: TextStyle(
                          color: MyColor.blackTextAT,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              padding: EdgeInsets.all(15),
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
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.location_on,
                            color: MyColor.redAT,
                          ),
                        ),
                        Text(
                          "PT Lorem Ipsum",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 10, left: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Nama Lengkap, ",
                            style: TextStyle(
                                fontSize: 16, color: MyColor.greyTextAT),
                          ),
                        ),
                        Container(
                          child: Text(
                            "08912321313",
                            style: TextStyle(
                                fontSize: 15, color: MyColor.greyTextAT),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, left: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Jl. Lorem Ipsum Dolor Ismet No 29, Lorem Ipsum Dolor Ismet Kabupaten Gresik Jawa Timur Indonesia",
                            style: TextStyle(
                                fontSize: 16, color: MyColor.greyTextAT),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MyDivider.spaceDividerLogin(custom: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: MyColor.redAT,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: FlatButton(
                      child: Text(
                        "Ganti Alamat",
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
            Container(
              height: 3,
              color: Color(0xffEAEAEA),
              margin: EdgeInsets.symmetric(vertical: 20),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
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
                          "Tanggal Ekspetasi Pengiriman",
                          style: TextStyle(
                              color: MyColor.blackTextAT,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Expanded(
                          child: Text(
                            "Pemesanan di atas jam 12 siang dan tanggal ekspetasi pada hari itu juga akan, berpotensi dikirimkan di hari selanjutnya.",
                            style: TextStyle(
                                color: MyColor.greyTextAT, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 25),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Color(0xffC8C8C8), width: 2),
                            bottom:
                                BorderSide(color: Color(0xffC8C8C8), width: 2),
                            left:
                                BorderSide(color: Color(0xffC8C8C8), width: 2),
                            right:
                                BorderSide(color: Color(0xffC8C8C8), width: 0),
                          ),
                        ),
                        child: Icon(
                          Icons.date_range,
                          color: MyColor.redAT,
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: IgnorePointer(
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffEEEEEE),
                                hintText:
                                    "${_date.day} / ${_date.month} / ${_date.year}",
//                              hintText: "${_date.toString()}",
                                contentPadding: const EdgeInsets.only(left: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffC8C8C8), width: 2.0),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyColor.redAT, width: 1),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
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
                      contentPadding: const EdgeInsets.only(left: 20, top: 30),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffC8C8C8), width: 2.0),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                          topLeft: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColor.redAT, width: 1),
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
              height: 3,
              color: Color(0xffEAEAEA),
              margin: EdgeInsets.symmetric(vertical: 20),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
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
                          "Produk",
                          style: TextStyle(
                              color: MyColor.blackTextAT,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.only(
                            top: 15,
                          ),
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
                              Container(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Image.asset(
                                        kImageDynamix,
                                        width: 100,
                                      ),
                                    ),
                                    Container(
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      "Semen PCC ZAK 50",
                                                      style: TextStyle(
                                                        color:
                                                            MyColor.blackTextAT,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              child: Text(
                                                "121-301-0060",
                                                style: TextStyle(
                                                  color: MyColor.greyTextAT,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      "Rp 60.000",
                                                      style: TextStyle(
                                                        color:
                                                            MyColor.blackTextAT,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text(
                                                            'Jumlah',
                                                            style: TextStyle(
                                                                color: Color(0xff999999),
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            '5 SAK',
                                                            style: TextStyle(
                                                                color: Color(0xff333333),
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 3,
                                color: Color(0xffEAEAEA),
                                margin: EdgeInsets.symmetric(vertical: 0),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "SUBTOTAL",
                                      style: TextStyle(
                                          color: Color(0xff999999),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Rp 10.000.000",
                                      style: TextStyle(
                                          color: Color(0xff333333),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
              margin: EdgeInsets.symmetric(vertical: 20),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                      bottom: 15,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Distributor",
                          style: TextStyle(
                              color: MyColor.blackTextAT,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Kode Distributor",
                          style: TextStyle(
                              color: MyColor.greyTextAT,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          "Nama Distributor",
                          style: TextStyle(
                              color: MyColor.greyTextAT,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                      bottom: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "0000088976",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "Lorem Ipsum",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
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
              margin: EdgeInsets.symmetric(vertical: 20),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
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
                          "Pengiriman",
                          style: TextStyle(
                              color: MyColor.blackTextAT,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 25),
                          child: DropDownField(
                            controller: shipingSelected,
                            hintText: "Pilih Pengiriman",
                            enabled: true,
                            itemsVisibleInDropdown: 3,
                            items: shiping,
                            onValueChanged: (value) {
                              setState(() {
                                selectShipping = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 3,
              color: Color(0xffEAEAEA),
              margin: EdgeInsets.symmetric(vertical: 20),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                      bottom: 15,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Ringkasan",
                          style: TextStyle(
                              color: MyColor.blackTextAT,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Jumlah Barang",
                          style: TextStyle(
                              color: MyColor.greyTextAT, fontSize: 16),
                        ),
                        Text(
                          "250",
                          style: TextStyle(
                              color: MyColor.greyTextAT,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Total Harga",
                          style: TextStyle(
                              color: MyColor.greyTextAT, fontSize: 16),
                        ),
                        Text(
                          "Rp 10.300.000",
                          style: TextStyle(
                              color: MyColor.greyTextAT,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Penambahan Harga Pengiriman",
                          style: TextStyle(
                              color: MyColor.greyTextAT, fontSize: 16),
                        ),
                        Text(
                          "Rp 10.300.000",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Total Harga Akhir",
                          style: TextStyle(
                              color: MyColor.greyTextAT,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rp 10.300.000",
                          style: TextStyle(
                              color: MyColor.redAT,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
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
              margin: EdgeInsets.symmetric(vertical: 20),
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
                  "Lanjut Pembayaran",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () {
                  Get.toNamed(paymentScreen);
                },
              ),
            ),
            Container(
              height: 3,
              color: Color(0xffEAEAEA),
              margin: EdgeInsets.only(top: 20),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          //color: Colors.white,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Container(
            child: Text(
              "Checkout",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        centerTitle: false,
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
}
