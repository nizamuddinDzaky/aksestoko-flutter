import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/screen/order/list_product_detail_screen.dart'
    as listProduct;
import 'package:get/get.dart';
import 'package:aksestokomobile/app/my_router.dart';

class DetailOrderScreen extends StatefulWidget {
  _DetailOrderScreenState createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 16,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              height: 270.0,
              width: 360.0,
              child: Column(
                children: <Widget>[
                  Text(
                    "Batalkan Pesanan",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 3,
                    color: Color(0xffEAEAEA),
                    margin: EdgeInsets.symmetric(vertical: 20),
                  ),
                  Expanded(
                    child: Center(
                        child: Text(
                      "Apakah Anda yakin membatalkan Pesanan ini ?",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Container(
                    height: 3,
                    color: Color(0xffEAEAEA),
                    margin: EdgeInsets.symmetric(vertical: 15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        decoration: BoxDecoration(
                          color: MyColor.greyTextAT,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: FlatButton(
                          child: Text(
                            "Batal",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        decoration: BoxDecoration(
                          color: MyColor.orangeAT,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: FlatButton(
                          child: Text(
                            "Iya",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var index = Get.arguments;
    debugPrint("index = $index");
    var formLayout = SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 25, left: 25, right: 25),
              child: Text(
                "Detail Pesanan",
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
                                "ID Pesnaan",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.greyTextAT),
                              ),
                              Text(
                                "SALE/AT/2020/0023",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                "ID Bisnis Kokoh",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.greyTextAT),
                              ),
                              Text(
                                "123456789",
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
                                "Tanggal Pemesanan",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.greyTextAT),
                              ),
                              Text(
                                "20 Desember 2020",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                "Tgl Ekspetasi Pengiriman",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.greyTextAT),
                              ),
                              Text(
                                "20 Desember 2020",
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
                                "Kode Distributor",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.greyTextAT),
                              ),
                              Text(
                                "000001390",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                "Nama Distributor",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.greyTextAT),
                              ),
                              Text(
                                "Lorem Ipsum Dolor Ismet",
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
                                "Cara Pengiriman",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.greyTextAT),
                              ),
                              Text(
                                "Pengiriman Distributor",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                "Cara Pembayaran",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.greyTextAT),
                              ),
                              if (index == 0)
                                Text(
                                  "Bayar Di Tempat",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (index == 1)
                                Text(
                                  "Tempo Distributor",
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
                  ),
                  Container(
                    height: 3,
                    color: Color(0xffEAEAEA),
                    margin: EdgeInsets.symmetric(vertical: 5),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15, top: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Status Pesanan",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.greyTextAT),
                              ),
                              if (index == 0)
                                Text(
                                  "Menunggu Konfirmasi",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: MyColor.warningTextAT,
                                  ),
                                ),
                              if (index == 1)
                                Text(
                                  "Dikonfirmasi",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: MyColor.greenAT,
                                  ),
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
                                "Status Pembayaran",
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.greyTextAT),
                              ),
                              if (index == 0)
                                Text(
                                  "Belum Bayar",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: MyColor.warningTextAT,
                                  ),
                                ),
                              if (index == 1)
                                Text(
                                  "Diterima Sebagian",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: MyColor.infoAT,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (index == 1)
                    Container(
                      child: FlatButton.icon(
                        onPressed: () {
                          Get.toNamed(detailPaymentScreen);
                        },
                        icon: Icon(
                          Icons.list,
                          color: MyColor.redAT,
                        ),
                        label: Text(
                          "Daftar Pembayaran",
                          style: TextStyle(color: MyColor.redAT, fontSize: 16),
                        ),
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
                              "Jumlah Pesanan",
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
                              "Jumlah Diterima",
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
                              "Sisa Pesanan",
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
                  Container(
                    height: 3,
                    color: Color(0xffEAEAEA),
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Total Harga",
                          style: TextStyle(
                              fontSize: 16, color: MyColor.greyTextAT),
                        ),
                        Text(
                          "Rp 10.000.000",
                          style: TextStyle(
                              color: MyColor.blackTextAT,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 3,
                    color: Color(0xffEAEAEA),
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Total Pembayaran",
                          style: TextStyle(
                              fontSize: 16, color: MyColor.greyTextAT),
                        ),
                        Text(
                          "Rp 10.000.000",
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
            if (index == 1)
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(left: 25, right: 25, top: 25),
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
                                      fontSize: 16, color: MyColor.greyTextAT),
                                ),
                                Text(
                                  "DO/2020/05/0023",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                      fontSize: 16, color: MyColor.greyTextAT),
                                ),
                                Text(
                                  "Dalam Pengiriman",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MyColor.infoAT),
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
                                      fontSize: 16, color: MyColor.greyTextAT),
                                ),
                                Text(
                                  "20 Desember 2020",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                  "Dikirim Oleh",
                                  style: TextStyle(
                                      fontSize: 16, color: MyColor.greyTextAT),
                                ),
                                Text(
                                  "Bpk. Lorem Ipsum",
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
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      height: 40,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: MyColor.greenAT,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: FlatButton(
                        child: Text(
                          "Konfirmasi Penerimaan",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        onPressed: () {
                          Get.toNamed(confirmationAcceptScreen);
                        },
                      ),
                    ),
                    Container(
                      height: 3,
                      color: Color(0xffEAEAEA),
                      margin: EdgeInsets.symmetric(vertical: 5),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Barang yang Dikirim",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          listProductShipment(),
                          listProductShipment()
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
                "Pengiriman",
                style: TextStyle(
                    color: MyColor.blackTextAT,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
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
            Container(
              height: 3,
              color: Color(0xffEAEAEA),
              margin: EdgeInsets.symmetric(vertical: 30),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25, left: 25, right: 25),
              child: Row(
                children: <Widget>[
                  Text(
                    "Daftar Belanja",
                    style: TextStyle(
                        color: MyColor.blackTextAT,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                  Text(
                    "(2)",
                    style: TextStyle(
                        color: MyColor.blackTextAT,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              padding:
                  EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
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
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  listProduct.ListProductDetailOrderScreen(),
                  listProduct.ListProductDetailOrderScreen(),
                ],
              ),
            ),
            if (index == 0)
            Container(
              height: 3,
              color: Color(0xffEAEAEA),
              margin: EdgeInsets.symmetric(vertical: 20),
            ),
            if (index == 0)
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: MyColor.orangeAT,
                borderRadius: BorderRadius.circular(30),
              ),
              child: FlatButton(
                child: Text(
                  "Batalkan Pesanan",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () {
                  createAlertDialog(context);
                },
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
            "Detail Pemesanan",
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
  Widget listProductShipment() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 10),
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
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "SEMEN PCC ZAK 40KG",
                  style: TextStyle(
                      fontSize: 18,
                      color: MyColor.redAT,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "121-301-0050",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Jumlah",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  "100 SAK",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MyColor.infoAT,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
