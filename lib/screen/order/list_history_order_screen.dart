import 'package:aksestokomobile/model/order.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ListHistoryOrderProductScreen extends StatelessWidget {
  final int _index;
  final Order _order;

  ListHistoryOrderProductScreen(this._index, this._order);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
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
          if (_order?.duration != null)
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: MyColor.orangeAT,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    "Sisa Durasi Waktu Pembayaran :",
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    '${_order?.duration} hari',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ID Pemesanan",
                          style: TextStyle(
                              color: MyColor.greyTextAT, fontSize: 15),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                        ),
                        Text(
                          _order?.noPemesanan ?? '',
                          style: TextStyle(
                              color: MyColor.redAT,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "(Forca POS)",
                          style: TextStyle(color: MyColor.redAT),
                        ),
                      ],
                    )),
                    SizedBox(width: 8),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tanggal",
                          style: TextStyle(
                              color: MyColor.greyTextAT, fontSize: 15),
                        ),
                        Text(
                          _order?.tanggalPemensanan ?? '',
                          style: TextStyle(
                              color: MyColor.blackTextAT,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status Pesanan",
                          style: TextStyle(
                              color: MyColor.greyTextAT, fontSize: 15),
                        ),
                        Text(
                          _order?.statusPemesanan ?? '',
                          style: TextStyle(
                              color: MyColor.greenAT,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
                    SizedBox(width: 8),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status Pembayaran",
                          style: TextStyle(
                              color: MyColor.greyTextAT, fontSize: 15),
                        ),
                        Text(
                          _order?.statusPembayaran ?? '',
                          style: TextStyle(
                              color: MyColor.infoAT,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
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
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                        child: Image.asset(
                          kImageDynamix,
                          width: 100,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                _order?.productName ?? '',
                                style: TextStyle(
                                  color: MyColor.blackTextAT,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _order?.productCode ?? '',
                                    style: TextStyle(
                                      color: MyColor.greyTextAT,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    MyNumber.toNumberRp(
                                        _order?.unitCost?.toDouble() ?? 0.0),
                                    style: TextStyle(
                                      color: MyColor.greyTextAT,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Jumlah",
                                        style: TextStyle(
                                          color: MyColor.blackTextAT,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            MyNumber.toNumberId(
                                                _order?.quantity?.toDouble() ??
                                                    0.0),
                                            style: TextStyle(
                                              color: MyColor.blackTextAT,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2),
                                          ),
                                          Text(
                                            _order?.satuan ?? '',
                                            style: TextStyle(
                                              color: MyColor.blackTextAT,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width /
                                            16),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Harga",
                                          style: TextStyle(
                                            color: MyColor.blackTextAT,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          MyNumber.toNumberRp(
                                              _order?.hargaBarang?.toDouble() ??
                                                  0.0),
                                          style: TextStyle(
                                            color: MyColor.blackTextAT,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
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
                    ],
                  ),
                ),
/*
                Container(
                  height: 3,
                  color: Color(0xffEAEAEA),
                  margin: EdgeInsets.symmetric(vertical: 0),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Text("+1 barang lainya"),
                ),
*/
                if (_index == 1)
                  Container(
                    height: 3,
                    color: Color(0xffEAEAEA),
                    margin: EdgeInsets.symmetric(vertical: 0),
                  ),
                if (_index == 1)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
              ],
            ),
          ),
          Container(
            height: 3,
            color: Color(0xffEAEAEA),
            margin: EdgeInsets.only(top: 10, bottom: 0),
          ),
          Container(
            margin: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "TOTAL",
                        style: TextStyle(color: MyColor.greyTextAT),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                      ),
                      Text(
                        MyNumber.toNumberRp(
                            _order?.totalHarga?.toDouble() ?? 0.0),
                        style: TextStyle(
                            color: MyColor.greyTextAT,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: CupertinoButton(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      'LIHAT DETAIL',
                      style: TextStyle(
                        color: MyColor.redAT,
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed(
                          detailOrderScreen, arguments: _order?.idPemesanan);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
