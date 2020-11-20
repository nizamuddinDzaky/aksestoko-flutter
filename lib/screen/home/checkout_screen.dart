import 'package:aksestokomobile/controller/home/checkout_controller.dart';
import 'package:aksestokomobile/model/checkout_model.dart';
import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/screen/account/address_controller.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:aksestokomobile/view_model/home/checkout_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';
import 'package:aksestokomobile/helper/my_divider.dart';
import 'package:flutter/services.dart';

import 'list_address_screen.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends CheckoutViewModel {
  @override
  Widget build(BuildContext context) {
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
              "Periksa",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        centerTitle: false,
        actions: <Widget>[],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: complete == null
            ? Center(child: CircularProgressIndicator())
            : (complete != 0
                ? GetBuilder<CheckoutController>(
                    init: CheckoutController(),
                    builder: (controller) => RefreshIndicator(
                      onRefresh: actionRefresh,
                      child: _layout(controller, context),
                    ),
                  )
                : Center(
                    child: RaisedButton(
                      child: Text('Gagal, kembali ke halaman depan'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  )),
      ),
    );
  }

  Widget _layout(CheckoutController controller, BuildContext context) {
    return SingleChildScrollView(
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          address?.namaToko ?? '',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 10, left: 10),
                    child: Text(
                      address?.line1 ?? '',
                      style: TextStyle(fontSize: 16, color: MyColor.greyTextAT),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, left: 10),
                    child: Text(
                      address?.line2 ?? '',
                      style: TextStyle(fontSize: 16, color: MyColor.greyTextAT),
                    ),
                  ),
                ],
              ),
            ),
            MyDivider.spaceDividerLogin(custom: 10),
            if (kDebugMode)
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
                        onPressed: () =>
                            _dialogListAddress(context).then((value) {
                              setState(() {
                                if (value == null) return;
                                address.namaPenerima =
                                    value?.namaPenerima ?? address.namaPenerima;
                                address.email = value?.email ?? address.email;
                                address.noTlpn = value?.noTlpn ?? address.noTlpn;
                                address.alamat = value?.alamat ?? address.alamat;
                                address.provinceName =
                                    value?.provinceName ?? address.provinceName;
                                address.kabupatenName =
                                    value?.kabupatenName ?? address.kabupatenName;
                                address.kecamatanName =
                                    value?.kecamatanName ?? address.kecamatanName;
                              });
                            }),
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
                          onTap: () async {
                            DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: controller.date,
                              firstDate: DateTime(2015),
                              locale: Locale('in', 'ID'),
                              lastDate: DateTime(2030),
                            );
                            controller.setDate(picked);
                          },
                          child: IgnorePointer(
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffEEEEEE),
                                hintText: strToDate(controller.date.toString()),
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
                  TextFormField(
                    controller: controller.noteSales,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    maxLength: 1000,
                    onSaved: (value) => {},
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
            //listitem
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
                  Container(child: _listItem())
                ],
              ),
            ),
            Container(
              height: 3,
              color: Color(0xffEAEAEA),
              margin: EdgeInsets.symmetric(vertical: 20),
            ),
            //distributor
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kode Distributor",
                              style: TextStyle(
                                  color: MyColor.greyTextAT,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            Text(
                              checkoutModel?.distributor?.kode ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Nama Distributor",
                                style: TextStyle(
                                    color: MyColor.greyTextAT,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              Text(
                                checkoutModel?.distributor?.nama ?? '',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
            //pengiriman
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
                          child: DropdownSearch<Shipment>(
                            items: checkoutModel?.listPengiriman ?? [],
                            onSaved: (value) => {},
                            hint: "Pilih Pengiriman",
                            onChanged: (Shipment data) {
                              selectShipping = data;
                              getShipment();
                            },
                            showSearchBox: true,
                            selectedItem: selectShipping,
                            searchBoxDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              labelText: "Cari Pengiriman",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (complete != 2)
                    Text(
                      'Gagal mengambil info biaya pengiriman',
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption
                          .copyWith(
                          color: Colors.red, fontStyle: FontStyle.italic
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
            //ringkasan
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
                            "${MyNumber.toNumberId(checkoutModel?.ringkasan?.jumlahBarang?.toDouble() ?? 0.0)}",
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
                          Expanded(
                            child: Text(
                              "Total Harga",
                              style: TextStyle(
                                  color: MyColor.greyTextAT, fontSize: 16),
                            ),
                          ),
                          Text(
                            "${MyNumber.toNumberRp(checkoutModel?.ringkasan
                                ?.totalHarga?.toDouble() ?? 0.0)}",
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
                          Expanded(
                            child: Text(
                              "Penambahan Harga Pengiriman",
                              style: TextStyle(
                                  color: MyColor.greyTextAT, fontSize: 16),
                            ),
                          ),
                          Text(
                            "${MyNumber.toNumberRp(checkoutModel?.ringkasan
                                ?.cost?.toDouble() ?? 0.0)}",
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
                          Expanded(
                            child: Text(
                              "Total Harga Akhir",
                              style: TextStyle(
                                  color: MyColor.greyTextAT,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "${MyNumber.toNumberRp(checkoutModel?.ringkasan
                                ?.grandTotal?.toDouble() ?? 0.0)}",
                            style: TextStyle(
                                color: MyColor.redAT,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
              height: 3,
              color: Color(0xffEAEAEA),
              margin: EdgeInsets.symmetric(vertical: 20),
            ),
            //diskon
            if (checkoutModel?.diskon?.potonganHarga?.isNotEmpty ?? false)
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
                              "Diskon",
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
                              "Kode Promo",
                              style: TextStyle(
                                  color: MyColor.greyTextAT, fontSize: 16),
                            ),
                            Text(
                              checkoutModel?.diskon?.codePromo ?? '',
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
                            Expanded(
                              child: Text(
                                "Potongan Harga",
                                style: TextStyle(
                                    color: MyColor.greyTextAT, fontSize: 16),
                              ),
                            ),
                            Text(
                              "${MyNumber.toNumberRpStr(checkoutModel?.diskon?.potonganHarga ?? '0')}",
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
                          top: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Total Pembayaran",
                                style: TextStyle(
                                    color: MyColor.greyTextAT,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "${MyNumber.toNumberRp(checkoutModel?.totalPembayaran ?? 0.0)}",
                              style: TextStyle(
                                  color: MyColor.redAT,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            if (checkoutModel?.diskon?.potonganHarga?.isNotEmpty ?? false)
              Container(
                height: 3,
                color: Color(0xffEAEAEA),
                margin: EdgeInsets.symmetric(vertical: 20),
              ),
            //lanjut pembayaran
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
                onPressed: () => actionToPayment(controller),
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
  }

  Widget _listItem() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          _item(context, checkoutModel?.listProduct[index]),
      itemCount: checkoutModel?.listProduct?.length ?? 0,
    );
  }

  Widget _item(BuildContext context, Product _product) {
    return Container(
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
            offset: Offset(0, 2), // changes position of shadow
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Row(
              children: <Widget>[
                Container(
                  height: 112,
                  width: 100,
                  child: kDebugMode || (_product?.imageUrl?.isEmpty ?? true)
                      ? Image.asset(kNoImage, height: 112)
                      : FadeInImage.assetNetwork(
                    placeholder: kNoImage,
                    image: _product?.imageUrl ?? '',
                    fit: BoxFit.cover,
                    width: 100,
                  ),
                ),
                Container(
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  _product?.nama ?? '',
                                  style: TextStyle(
                                    color: MyColor.blackTextAT,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            _product?.productCode ?? '',
                            style: TextStyle(
                              color: MyColor.greyTextAT,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "${MyNumber.toNumberRp(
                                      _product?.productPrice ?? 0.0)}",
                                  style: TextStyle(
                                    color: MyColor.blackTextAT,
                                    fontWeight: FontWeight.bold,
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
                                        MyNumber?.toNumberId(
                                            _product?.qty ?? 0.0),
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
            padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "SUBTOTAL",
                  style: TextStyle(
                      color: Color(0xff999999), fontWeight: FontWeight.bold),
                ),
                Text(
                  "${MyNumber.toNumberRp(_product?.totalPrice ?? 0.0)}",
                  style: TextStyle(
                      color: Color(0xff333333), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _dialogListAddress(BuildContext context) async {
    return showDialog(
      context: context,
      child: GetBuilder<AddressController>(
          init: AddressController(),
          builder: (vm) {
            return AlertDialog(
              title: Text('Daftar Alamat Toko'),
              content: ListAddressScreen()
            );
          }),
    );
  }
}
