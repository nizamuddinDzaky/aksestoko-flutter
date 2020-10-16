import 'package:aksestokomobile/controller/home/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/helper/my_divider.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends PaymentController {
  var rekening = '';

  List<String> _dynamicBank;
  List<String> _dynamicTempo;
  List<Color> _colorBank;
  int _value;
  int _tempo;

  bool cashOnDelivery = false;
  bool cashBeforeDelivery = false;
  bool kreditPro = false;
  bool tempoDistributor = false;
  int currentTab = 0;

  listBank() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: List<Widget>.generate(_dynamicBank.length, (int index) {
        return Container(
          margin: EdgeInsets.only(
            left: 4,
            right: 8,
            top: 0,
            bottom: 8,
          ),
          child: ChoiceChip(
            backgroundColor: _colorBank[index],
            labelPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            label: Text(
              _dynamicBank[index],
              style: TextStyle(
                  color: _value != index ? Colors.black : Colors.white),
            ),
            avatar: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 15,
              child: _value != index
                  ? Text('')
                  : Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
            ),
            selected: _value == index,
            selectedColor: _colorBank[index],
            onSelected: (bool selected) {
              setState(() {
                rekening = _dynamicBank[index];
                _value = selected ? index : null;
                debugPrint(_value?.toString());
              });
            },
          ),
        );
      }),
    );
  }

  listTempo() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: List<Widget>.generate(_dynamicTempo.length, (int index) {
        return Container(
          margin: EdgeInsets.only(
            left: 4,
            right: 8,
            top: 0,
            bottom: 8,
          ),
          child: ChoiceChip(
            labelPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            label: Text(
              _dynamicTempo[index],
              style: TextStyle(
                  color: _tempo != index ? Colors.black : Colors.white),
            ),
            avatar: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 15,
              child: _tempo != index
                  ? Text('')
                  : Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
            selected: _tempo == index,
            selectedColor: MyColor.redAT,
            onSelected: (bool selected) {
              setState(() {
                _tempo = selected ? index : null;
                debugPrint(_tempo?.toString());
              });
            },
          ),
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _dynamicBank = ['Mandiri', 'BCA', 'BNI', 'BRI'];
    _dynamicTempo = ['30 Hari', '45 Hari', '60 Hari'];
    _colorBank = [
      Color(0xFFff8a65),
      Color(0xFF4fc3f7),
      Color(0xFF9575cd),
      Color(0xFF4db6ac)
    ];
    _value = 0;
    _tempo = 0;
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
                      "Silahkan Pilih Methode Pembayaran",
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    color: currentTab == 0 ? MyColor.redAT : Colors.white,
                    child: Text(
                      "Tunai",
                      style: TextStyle(
                          color: currentTab == 0 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    onPressed: () {
                      setState(() {
                        currentTab = 0;
                      });
                    },
                  ),
                  FlatButton(
                    color: currentTab == 1 ? MyColor.redAT : Colors.white,
                    child: Text(
                      "Kredit",
                      style: TextStyle(
                          color: currentTab == 1 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    onPressed: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                  ),
                  Container(
                    height: 3,
                    color: Color(0xffEAEAEA),
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                  ),
                ],
              ),
            ),
            Container(
              height: 3,
              color: Color(0xffEAEAEA),
              margin: EdgeInsets.only(top: 20),
            ),
            if (currentTab == 0)
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: cashOnDelivery,
                                    onChanged: (bool value) {
                                      setState(() {
                                        cashOnDelivery = value;
                                        if (cashOnDelivery) {
                                          cashBeforeDelivery = false;
                                        }
                                      });
                                    },
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Image.asset(
                                      atPaymentCOD,
                                      width: 18,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 15,
                                      bottom: 15,
                                    ),
                                    child: Text(
                                      "Bayar Ditempat",
                                      style: TextStyle(
                                          color: MyColor.blackTextAT,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Rp 20.000.000",
                                style: TextStyle(
                                    color: MyColor.redAT,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                          Container(
                            height: 3,
                            color: Color(0xffEAEAEA),
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                          ),
                          if (cashOnDelivery)
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
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  )
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
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
                                            "Rp 20.000.000",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "Pengiriman Ditributor",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Rp 20.000.000",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 3,
                                    color: Color(0xffEAEAEA),
                                    margin:
                                    EdgeInsets.only(top: 10, bottom: 20),
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
                                        Container(
                                          child: Text(
                                            "Rp 20.000.000",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.redAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (cashOnDelivery)
                            MyDivider.spaceDividerLogin(custom: 10),
                          if (cashOnDelivery)
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: MyColor.greenAT,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: FlatButton(
                                      child: Text(
                                        "Seleseikan",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      onPressed: () {
                                        Get.toNamed(successScreen);
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
              ),
            if (currentTab == 0)
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: cashBeforeDelivery,
                                    onChanged: (bool value) {
                                      setState(() {
                                        cashBeforeDelivery = value;
                                        if (cashBeforeDelivery) {
                                          cashOnDelivery = false;
                                        }
                                      });
                                    },
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Image.asset(
                                      atPaymentCBD,
                                      width: 18,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 15,
                                      bottom: 15,
                                    ),
                                    child: Text(
                                      "Bayar Sebelum Dikirim",
                                      style: TextStyle(
                                          color: MyColor.blackTextAT,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Rp 20.000.000",
                                style: TextStyle(
                                    color: MyColor.redAT,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                          Container(
                            height: 3,
                            color: Color(0xffEAEAEA),
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                          ),
                          if (cashBeforeDelivery)
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: listBank(),
                              ),
                            ),
                          if (cashBeforeDelivery)
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Nomor Rekening Tujuan",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MyColor.greyTextAT,
                                            fontSize: 16),
                                      ),
                                      MyDivider.spaceDividerElementsAT(
                                          custom: 5),
                                      Text(
                                        rekening,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MyColor.blackTextAT,
                                            fontSize: 16),
                                      ),
                                      MyDivider.spaceDividerElementsAT(
                                          custom: 5),
                                      Text(
                                        "a/n Lorem Ipsum",
                                        style: TextStyle(
                                            color: MyColor.blackTextAT,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    atBankExample,
                                    width: 120,
                                  ),
                                ],
                              ),
                            ),
                          if (cashBeforeDelivery)
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
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  )
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
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
                                            "Rp 20.000.000",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "Pengiriman Ditributor",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Rp 20.000.000",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 3,
                                    color: Color(0xffEAEAEA),
                                    margin:
                                    EdgeInsets.only(top: 10, bottom: 20),
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
                                        Container(
                                          child: Text(
                                            "Rp 20.000.000",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.redAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (cashBeforeDelivery)
                            MyDivider.spaceDividerElementsAT(custom: 10),
                          if (cashBeforeDelivery)
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: MyColor.greenAT,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: FlatButton(
                                      child: Text(
                                        "Seleseikan",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      onPressed: () {
                                        Get.toNamed(successScreen);
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
              ),
            if (currentTab == 1)
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: tempoDistributor,
                                    onChanged: (bool value) {
                                      setState(() {
                                        tempoDistributor = value;
                                      });
                                    },
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Image.asset(
                                      atPaymentTempoDistributor,
                                      width: 18,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 15,
                                      bottom: 15,
                                    ),
                                    child: Text(
                                      "Tempo Distributor",
                                      style: TextStyle(
                                          color: MyColor.blackTextAT,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Rp 200.000.000.000",
                                    style: TextStyle(
                                        color: MyColor.redAT,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "30 Hari",
                                    style: TextStyle(
                                        color: MyColor.greyTextAT,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 3,
                            color: Color(0xffEAEAEA),
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                          ),
                          if (tempoDistributor)
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: listBank(),
                              ),
                            ),
                          if (tempoDistributor)
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Nomor Rekening Tujuan",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MyColor.greyTextAT,
                                            fontSize: 16),
                                      ),
                                      MyDivider.spaceDividerElementsAT(
                                          custom: 5),
                                      Text(
                                        "19827364",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MyColor.blackTextAT,
                                            fontSize: 16),
                                      ),
                                      MyDivider.spaceDividerElementsAT(
                                          custom: 5),
                                      Text(
                                        "a/n Lorem Ipsum",
                                        style: TextStyle(
                                            color: MyColor.blackTextAT,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    atBankExample,
                                    width: 120,
                                  ),
                                ],
                              ),
                            ),
                          if (tempoDistributor)
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
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  )
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
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
                                            "Rp 20.000.000",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "Pengiriman Ditributor",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Rp 20.000.000",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 3,
                                    color: Color(0xffEAEAEA),
                                    margin:
                                    EdgeInsets.only(top: 10, bottom: 20),
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
                                        Container(
                                          child: Text(
                                            "Rp 20.000.000",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.redAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (tempoDistributor)
                            MyDivider.spaceDividerElementsAT(custom: 20),
                          if (tempoDistributor)
                            Column(
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
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Expanded(
                                        child: Text(
                                          "Hanya sebagai pengingat Toko, tidak berimbas menjadi batas pembayaran Toko",
                                          style: TextStyle(
                                              color: MyColor.greyTextAT,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin:
                                      EdgeInsets.symmetric(vertical: 25),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color: Color(0xffC8C8C8),
                                              width: 2),
                                          bottom: BorderSide(
                                              color: Color(0xffC8C8C8),
                                              width: 2),
                                          left: BorderSide(
                                              color: Color(0xffC8C8C8),
                                              width: 2),
                                          right: BorderSide(
                                              color: Color(0xffC8C8C8),
                                              width: 0),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.date_range,
                                        color: MyColor.redAT,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Color(0xffEEEEEE),
                                          hintText: "30 Hari",
                                          contentPadding:
                                          const EdgeInsets.only(left: 20),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffC8C8C8),
                                                width: 2.0),
                                            borderRadius:
                                            const BorderRadius.only(
                                              topRight: Radius.circular(5.0),
                                              bottomRight: Radius.circular(5.0),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: MyColor.redAT, width: 1),
                                            borderRadius:
                                            const BorderRadius.only(
                                              topRight: Radius.circular(5.0),
                                              bottomRight: Radius.circular(5.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          if (tempoDistributor)
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: MyColor.greenAT,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: FlatButton(
                                      child: Text(
                                        "Seleseikan",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      onPressed: () {
                                        Get.toNamed(successScreen);
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
              ),
            if (currentTab == 1)
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: kreditPro,
                                    onChanged: (bool value) {
                                      setState(() {
                                        kreditPro = value;
                                      });
                                    },
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Image.asset(
                                      atPaymentKreditPro,
                                      width: 40,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 15,
                                      bottom: 15,
                                    ),
                                    child: Text(
                                      "KreditPro",
                                      style: TextStyle(
                                          color: MyColor.blackTextAT,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Rp 200.000.000.000",
                                    style: TextStyle(
                                        color: MyColor.redAT,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "30 Hari",
                                    style: TextStyle(
                                        color: MyColor.greyTextAT,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 3,
                            color: Color(0xffEAEAEA),
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                          ),
                          if (kreditPro)
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: listTempo(),
                              ),
                            ),
                          if (kreditPro)
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
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  )
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
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
                                            "Rp 20.000.000",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "Pengiriman Ditributor",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Rp 20.000.000",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 3,
                                    color: Color(0xffEAEAEA),
                                    margin:
                                    EdgeInsets.only(top: 10, bottom: 20),
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
                                        Container(
                                          child: Text(
                                            "Rp 200.000.000.000",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.redAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (kreditPro)
                            MyDivider.spaceDividerElementsAT(custom: 20),
                          if (kreditPro)
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: MyColor.greenAT,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: FlatButton(
                                      child: Text(
                                        "Seleseikan",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      onPressed: () {
                                        Get.toNamed(successScreen);
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
                  "Selesaikan",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () {
                  Get.toNamed(successScreen);
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
      // key: _key,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          //color: Colors.white,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Text(
            "Methode Pembayaran",
            style: TextStyle(fontSize: 20),
          ),
        ),
        centerTitle: false,
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
