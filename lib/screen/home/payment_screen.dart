import 'package:aksestokomobile/controller/home/payment_controller.dart';
import 'package:aksestokomobile/model/payment_model.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/widgets.dart';
import 'package:aksestokomobile/helper/my_divider.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends PaymentController {
  listBank(int indexPayment) {
    List<ListBank> listBank = [];
    if (tempoDistributor)
      listBank = [...(paymentModel?.tempoDenganDistributor?.listBank ?? [])];
    if (cashBeforeDelivery)
      listBank = [...(paymentModel?.bayarSebelumDikirim?.listBank ?? [])];
    listBank.insert(0, ListBank(bankName: 'Tunai'.toUpperCase()));
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: List<Widget>.generate(listBank?.length ?? 0, (int index) {
        return Container(
          margin: EdgeInsets.only(
            left: 4,
            right: 8,
            top: 0,
            bottom: 8,
          ),
          child: ChoiceChip(
            backgroundColor: colorBank[index % colorBank.length],
            labelPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            label: Text(
              listBank[index]?.bankName?.toUpperCase() ?? '',
              style: TextStyle(
                  color: indexBank[indexPayment] != index
                      ? Colors.black
                      : Colors.white),
            ),
            avatar: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 15,
              child: indexBank[indexPayment] != index
                  ? Text('')
                  : Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
            ),
            selected: indexBank[indexPayment] == index,
            selectedColor: colorBank[index % colorBank.length],
            onSelected: (bool selected) {
              if (!selected) return;
              setState(() {
                indexBank[indexPayment] = selected ? index : null;
                if (tempoDistributor)
                  selectedDue = indexBank == null ? null : listBank[index];
                if (cashBeforeDelivery)
                  selectedDelivery = indexBank == null ? null : listBank[index];
              });
            },
          ),
        );
      }),
    );
  }

  listTempo() {
    List<Detail> listTempo = paymentModel?.kreditPro?.detail ?? [];
    selectedKreditPro == selectedKreditPro ?? listTempo?.first;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: List<Widget>.generate(listTempo?.length ?? 0, (int index) {
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
              "${listTempo[index]?.durasiPembayaran ?? '-'}",
              style: TextStyle(
                  color: indexTempo != index ? Colors.black : Colors.white),
            ),
            avatar: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 15,
              child: indexTempo != index
                  ? Text('')
                  : Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
            ),
            selected: indexTempo == index,
            selectedColor: MyColor.redAT,
            onSelected: (bool selected) {
              setState(() {
                indexTempo = selected ? index : null;
                selectedKreditPro =
                    indexTempo == null ? null : listTempo[index];
              });
            },
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var formLayout = SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        height: isFirst ||
                paymentModel == null ||
                (currentTab == 1 && isEmptyCredit) ||
                (currentTab == 0 && isEmptyCash)
            ? (Get.height -
                (MediaQuery.of(context).padding.top + kToolbarHeight))
            : null,
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
                      "Silahkan Pilih Metode Pembayaran",
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
            if (isFirst)
              Flexible(child: Center(child: CircularProgressIndicator())),
            if (!isFirst && paymentModel == null)
              Flexible(
                child: Center(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Gagal load daftar pembayaran',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline6,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            if (!isFirst &&
                ((currentTab == 1 && isEmptyCredit) ||
                    (currentTab == 0 && isEmptyCash)))
              Flexible(
                child: Center(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Tidak ada pembayaran tersedia',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline6,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            if (currentTab == 0 && paymentModel?.bayarDitempat != null)
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
                                  Radio(
                                    groupValue: paymentMethod,
                                    value:
                                        PaymentController.listPaymentMethod[0],
                                    onChanged: (val) {
                                      setIndexMethod(val);
                                      setState(() {});
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
                                MyNumber.toNumberRp(paymentModel
                                    ?.bayarDitempat?.total
                                    ?.toDouble() ??
                                    0.0),
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
                                            MyNumber.toNumberRp(paymentModel
                                                ?.bayarDitempat
                                                ?.detail
                                                ?.harga
                                                ?.toDouble() ??
                                                0.0),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (paymentModel
                                          ?.bayarDitempat?.detail?.charge !=
                                      null)
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
                                              MyNumber.toNumberRp(paymentModel
                                                      ?.bayarDitempat
                                                      ?.detail
                                                      ?.charge
                                                      ?.toDouble() ??
                                                  0.0),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: MyColor.greyTextAT,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (paymentModel
                                          ?.bayarDitempat?.detail?.disocunt !=
                                      null)
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
                                              MyNumber.toNumberRp(paymentModel
                                                      ?.bayarDitempat
                                                      ?.detail
                                                      ?.disocunt ??
                                                  0.0),
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
                                            MyNumber.toNumberRp(paymentModel
                                                ?.bayarDitempat
                                                ?.detail
                                                ?.total
                                                ?.toDouble() ??
                                                0.0),
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
                                        "Selesaikan",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      onPressed: () {
                                        actionSubmit();
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
            if (currentTab == 0 && paymentModel?.bayarSebelumDikirim != null)
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      groupValue: paymentMethod,
                                      value: PaymentController
                                          .listPaymentMethod[1],
                                      onChanged: (val) {
                                        setIndexMethod(val);
                                        setState(() {});
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Image.asset(
                                        atPaymentCBD,
                                        width: 18,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
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
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                MyNumber.toNumberRp(paymentModel
                                    ?.bayarSebelumDikirim?.total
                                    ?.toDouble() ??
                                    0.0),
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
                                child: listBank(0),
                              ),
                            ),
                          if (cashBeforeDelivery &&
                              selectedDelivery?.bankId != null)
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
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
                                          '${selectedDelivery?.noRek ?? ' '}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: MyColor.blackTextAT,
                                              fontSize: 16),
                                        ),
                                        MyDivider.spaceDividerElementsAT(
                                            custom: 5),
                                        Text(
                                          'a.n. ${selectedDelivery?.nama ??
                                              ' '}',
                                          style: TextStyle(
                                              color: MyColor.blackTextAT,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (selectedDelivery?.logoBank?.isNotEmpty ??
                                      false)
                                    Image.network(
                                      selectedDelivery?.logoBank,
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
                                            MyNumber.toNumberRp(paymentModel
                                                ?.bayarSebelumDikirim
                                                ?.detail
                                                ?.harga
                                                ?.toDouble() ??
                                                0.0),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if ((paymentModel
                                      ?.tempoDenganDistributor
                                      ?.detail
                                      ?.charge
                                      ?.toDouble() ??
                                      0.0) != 0)
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
                                              MyNumber.toNumberRp(paymentModel
                                                  ?.bayarSebelumDikirim
                                                  ?.detail
                                                  ?.charge
                                                  ?.toDouble() ??
                                                  0.0),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: MyColor.greyTextAT,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (paymentModel?.bayarDitempat?.detail
                                      ?.disocunt != null)
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
                                              MyNumber.toNumberRp(paymentModel
                                                  ?.bayarDitempat
                                                  ?.detail
                                                  ?.disocunt ??
                                                  0.0),
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
                                            MyNumber.toNumberRp(paymentModel
                                                ?.bayarSebelumDikirim
                                                ?.detail
                                                ?.total
                                                ?.toDouble() ??
                                                0.0),
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
                                        "Selesaikan",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      onPressed: () {
                                        actionSubmit();
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
            if (currentTab == 1 && paymentModel?.tempoDenganDistributor != null)
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      groupValue: paymentMethod,
                                      value: PaymentController
                                          .listPaymentMethod[2],
                                      onChanged: (val) {
                                        setIndexMethod(val);
                                        setState(() {});
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Image.asset(
                                        atPaymentTempoDistributor,
                                        width: 18,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
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
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    MyNumber.toNumberRp(paymentModel
                                        ?.tempoDenganDistributor?.total
                                        ?.toDouble() ??
                                        0.0),
                                    style: TextStyle(
                                        color: MyColor.redAT,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "(${selectedDuration?.duration ??
                                        '-'} Hari)",
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
                                child: listBank(1),
                              ),
                            ),
                          if (tempoDistributor && selectedDue?.bankId != null)
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
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
                                          "${selectedDue?.noRek ?? ''}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: MyColor.blackTextAT,
                                              fontSize: 16),
                                        ),
                                        MyDivider.spaceDividerElementsAT(
                                            custom: 5),
                                        Text(
                                          "a/n ${selectedDue?.nama ?? ''}",
                                          style: TextStyle(
                                              color: MyColor.blackTextAT,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (selectedDue?.logoBank?.isNotEmpty ??
                                      false)
                                    Image.network(
                                      selectedDue?.logoBank,
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
                                            MyNumber.toNumberRp(paymentModel
                                                ?.tempoDenganDistributor
                                                ?.detail
                                                ?.harga
                                                ?.toDouble() ??
                                                0.0),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if ((paymentModel
                                      ?.tempoDenganDistributor
                                      ?.detail
                                      ?.hargaTempo
                                      ?.toDouble() ??
                                      0.0) != 0)
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              "Biaya Tempo",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: MyColor.greyTextAT),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              MyNumber.toNumberRp(paymentModel
                                                  ?.tempoDenganDistributor
                                                  ?.detail
                                                  ?.hargaTempo
                                                  ?.toDouble() ??
                                                  0.0),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: MyColor.greyTextAT,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if ((paymentModel
                                      ?.tempoDenganDistributor
                                      ?.detail
                                      ?.charge
                                      ?.toDouble() ??
                                      0.0) != 0)
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
                                              MyNumber.toNumberRp(paymentModel
                                                  ?.tempoDenganDistributor
                                                  ?.detail
                                                  ?.charge
                                                  ?.toDouble() ??
                                                  0.0),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: MyColor.greyTextAT,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (paymentModel?.bayarDitempat?.detail
                                      ?.disocunt != null)
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
                                              MyNumber.toNumberRp(paymentModel
                                                  ?.bayarDitempat
                                                  ?.detail
                                                  ?.disocunt ??
                                                  0.0),
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
                                            MyNumber.toNumberRp(paymentModel
                                                ?.tempoDenganDistributor
                                                ?.detail
                                                ?.total
                                                ?.toDouble() ??
                                                0.0),
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
                                        "Rencana Pelunasan",
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
                                  children: [
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
                                      child: DropdownSearch<ListPaymentDurasi>(
                                        dropdownSearchDecoration:
                                        InputDecoration(
                                          contentPadding:
                                          EdgeInsets.only(left: 20),
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
                                        items: paymentModel
                                            ?.tempoDenganDistributor
                                            ?.listPaymentDurasi ??
                                            [],
                                        onSaved: (value) => {},
                                        hint: "Pilih Durasi",
                                        onChanged: (ListPaymentDurasi data) {
                                          selectedDuration = data;
                                        },
                                        showSearchBox: true,
                                        selectedItem: selectedDuration,
                                        searchBoxDecoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Cari Durasi",
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
                                        "Selesaikan",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      onPressed: () {
                                        actionSubmit();
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
            if (currentTab == 1 && paymentModel?.kreditPro != null)
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      groupValue: paymentMethod,
                                      value: PaymentController
                                          .listPaymentMethod[3],
                                      onChanged: (val) {
                                        setIndexMethod(val);
                                        setState(() {});
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Image.asset(
                                        atPaymentKreditPro,
                                        width: 40,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
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
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    MyNumber.toNumberRp(
                                        selectedKreditPro?.total?.toDouble() ??
                                            0.0),
                                    style: TextStyle(
                                        color: MyColor.redAT,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "(${selectedKreditPro?.durasiPembayaran ??
                                        '-'})",
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
                                            MyNumber.toNumberRp(
                                                selectedKreditPro?.harga
                                                    ?.toDouble() ??
                                                    0.0),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if ((selectedKreditPro?.charge ?? 0) != 0)
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
                                              MyNumber.toNumberRp(
                                                  selectedKreditPro?.charge
                                                      ?.toDouble() ??
                                                      0.0),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: MyColor.greyTextAT,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if ((selectedKreditPro?.disocunt ?? 0) != 0)
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
                                              MyNumber.toNumberRp(
                                                  selectedKreditPro?.disocunt ??
                                                      0.0),
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
                                            "Sub Total",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColor.greyTextAT),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            MyNumber.toNumberRp(
                                                selectedKreditPro?.subtotal
                                                    ?.toDouble() ??
                                                    0.0),
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
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Interest Rate ',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                      MyColor.greyTextAT),
                                                ),
                                                TextSpan(
                                                  text:
                                                  '${selectedKreditPro
                                                      ?.interestRate ?? ''}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color:
                                                      MyColor.greyTextAT),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            MyNumber.toNumberRp(
                                                selectedKreditPro
                                                    ?.hargaInterestRate
                                                    ?.toDouble() ??
                                                    0.0),
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
                                            MyNumber.toNumberRp(
                                                selectedKreditPro?.total
                                                    ?.toDouble() ??
                                                    0.0),
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
                                  if (1000000.0 <
                                      (selectedKreditPro?.total?.toDouble() ??
                                          0.0))
                                    Container(
                                      padding:
                                      EdgeInsets.only(left: 10, right: 10),
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
                                          actionSubmit();
                                        },
                                      ),
                                    )
                                  else
                                    Container(
                                        child: Flexible(
                                          child: Text(
                                            'Total pesanan harus melebihi Rp 1.000.000 untuk dapat memilih metode ini.',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        )),
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
            "Metode Pembayaran",
            style: TextStyle(fontSize: 20),
          ),
        ),
        centerTitle: false,
        actions: <Widget>[],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: actionRefresh,
          child: formLayout,
        ),
      ),
    );
  }
}
