import 'package:aksestokomobile/helper/item.dart';
import 'package:aksestokomobile/model/delivery.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:aksestokomobile/view_model/order/detail_order_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/screen/order/list_product_detail_screen.dart'
    as listProduct;
import 'package:get/get.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailOrderScreen extends StatefulWidget {
  final String idPemesanan;
  final Item item;

  DetailOrderScreen({this.idPemesanan, this.item});

  _DetailOrderScreenState createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends DetailOrderViewModel {

  String get line2 => [
    [orderDetail.pengiriman.alamat, orderDetail.pengiriman.kecamatan, orderDetail.pengiriman.kabupaten, orderDetail.pengiriman.provinsi]
        .where((element) => (element?.isNotEmpty ?? false))
        .join(', '),
    orderDetail.pengiriman.kodePos
  ].where((element) => (element?.isNotEmpty ?? false)).join(' - ');

  @override
  Widget build(BuildContext context) {
    var formLayout =
    RefreshIndicator(
      key: refreshKey,
      onRefresh: () {
        return actionRefresh();
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if(orderDetail != null)
                if(orderDetail.konfirmasiHargaPesanan != null)
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(left: 25, right: 25),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: statusColor("info"),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Terdapat biaya tambahan sebesar ${MyNumber.toNumberRpStr(orderDetail.ringkasan.charge)}",
                          style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 10
                          ),
                        ),

                      ],
                    ),
                  ),
              if(orderDetail != null)
                if(orderDetail.konfirmasiHargaPesanan != null)
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(bottom: 25, left: 25, right: 25),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  color: MyColor.greenAT,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: FlatButton(
                                  child: Text(
                                    "Setuju",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                  onPressed: () {
                                    createAlertDialog(
                                        context,
                                        (orderDetail !=null ? orderDetail.detailPemesanan.idPemesanan : 0),
                                        "Apakah Anda yakin mengonfirmasi harga pesanan ini?",
                                        1,
                                        title: "Konfirmasi Harga"
                                    );
                                    /*putConfirmUpdatePrice(orderDetail.);*/
                                    /*actionCancelOrder(idPurchase);*/
                                    /*Get.toNamed(
                                        detailOrderScreen, arguments: _order?.idPemesanan);*/
                                    /*actionAddPayment();*/
                                    /*Get.toNamed(successScreen);*/
                                  },
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  color: MyColor.redAT,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: FlatButton(
                                  child: Text(
                                    "Tidak Setuju",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                  onPressed: () {
                                    createAlertDialog(
                                        context,
                                        (orderDetail !=null ? orderDetail.detailPemesanan.idPemesanan : 0),
                                        "Apakah Anda yakin membatalkan pesanan ini?",
                                        2
                                    );
                                    /*Get.toNamed(
                                        detailOrderScreen, arguments: _order?.idPemesanan);*/
                                    /*actionAddPayment();*/
                                    /*Get.toNamed(successScreen);*/
                                  },
                                ),
                              ),

                            ],
                          ),
                        )
                        /*Text(
                    '${_order?.duration} hari',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),*/
                      ],
                    ),
                  ),
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
              if(orderDetail != null && orderDetail.info1 != null)
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 25, right: 25),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: statusColor(orderDetail.pesan),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "${orderDetail.info1}",
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 10
                        ),
                      ),

                    ],
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "ID Pesanan",
                                  style: TextStyle(
                                      fontSize: 14, color: MyColor.greyTextAT),
                                ),
                                Text(
                                  orderDetail != null ? orderDetail
                                      .detailPemesanan.noPemesanan : "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "ID Bisnis Kokoh",
                                  style: TextStyle(
                                      fontSize: 14, color: MyColor.greyTextAT),
                                ),
                                Text(
                                  orderDetail != null ? orderDetail
                                      .detailPemesanan.idBk : "",
                                  style: TextStyle(
                                    fontSize: 14,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Tanggal Pemesanan",
                                  style: TextStyle(
                                      fontSize: 14, color: MyColor.greyTextAT),
                                ),
                                Text(
                                  orderDetail != null ? orderDetail
                                      .detailPemesanan.tanggalPeesanan : "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Tgl Ekspetasi Pengiriman",
                                  style: TextStyle(
                                      fontSize: 14, color: MyColor.greyTextAT),
                                ),
                                Text(
                                  orderDetail != null ? orderDetail
                                      .detailPemesanan.ekpestasi : "",
                                  style: TextStyle(
                                    fontSize: 14,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Kode Distributor",
                                  style: TextStyle(
                                      fontSize: 14, color: MyColor.greyTextAT),
                                ),
                                Text(
                                  orderDetail != null ? orderDetail
                                      .detailPemesanan.kodeDistributor : "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Nama Distributor",
                                  style: TextStyle(
                                      fontSize: 14, color: MyColor.greyTextAT),
                                ),
                                Text(
                                  orderDetail != null ? orderDetail
                                      .detailPemesanan.namaDistributor : "",
                                  style: TextStyle(
                                    fontSize: 14,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Cara Pengiriman",
                                  style: TextStyle(
                                      fontSize: 14, color: MyColor.greyTextAT),
                                ),
                                Text(
                                  orderDetail != null ? orderDetail
                                      .detailPemesanan.caraPengiriman : "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Cara Pembayaran",
                                  style: TextStyle(
                                      fontSize: 14, color: MyColor.greyTextAT),
                                ),
                                Text(

                                  orderDetail != null ? orderDetail
                                      .detailPemesanan.caraPembayaran : "",
                                  style: TextStyle(
                                    fontSize: 14,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          if (orderDetail?.detailPemesanan?.tanggalJatuhTempo !=
                              null)
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Tanggal Jatuh Tempo",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: MyColor.greyTextAT),
                                  ),
                                  Text(
                                    orderDetail != null
                                        ? orderDetail
                                            .detailPemesanan.tanggalJatuhTempo
                                        : "",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (orderDetail?.detailPemesanan?.tanggalJatuhTempo !=
                              null)
                            SizedBox(width: 8),
                          if (orderDetail?.detailPemesanan?.jenisPembayaran !=
                              null)
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Jenis Pembayaran",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: MyColor.greyTextAT),
                                  ),
                                  Text(
                                    orderDetail?.detailPemesanan
                                            ?.jenisPembayaran ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                        ),
                      ),
                    Divider(thickness: 2),
                    Container(
                      margin: EdgeInsets.only(bottom: 15, top: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Status Pesanan",
                                  style: TextStyle(
                                      fontSize: 14, color: MyColor.greyTextAT),
                                ),
                                Text(
                                  orderDetail != null ? orderDetail
                                      .detailPemesanan.statusPemesanan : "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor(
                                        orderDetail != null
                                            ? orderDetail.detailPemesanan
                                            .notifikasiPemesanan
                                            : ""),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Status Pembayaran",
                                  style: TextStyle(
                                      fontSize: 14, color: MyColor.greyTextAT),
                                ),
                                Text(
                                  orderDetail?.detailPemesanan
                                      ?.statusPembayaranStr ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor(
                                        orderDetail != null ? orderDetail
                                            .detailPemesanan
                                            .notifikasiPembayaran : ""),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (orderDetail?.detailPemesanan?.statusPembayaran
                        ?.toLowerCase() ==
                        'kredit ditolak')
                      Text(
                        'Pemesanan telah dibatalkan, karena pengajuan kredit ditolak.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    if (orderDetail != null)
                      if (orderDetail.detailPemesanan.daftarPembayaran != null)
                        Container(
                          child: FlatButton.icon(
                            onPressed: () {
                              Get.toNamed(detailPaymentScreen,
                                  arguments:
                                  orderDetail.detailPemesanan.idPemesanan);
                            },
                            icon: Icon(
                              Icons.list,
                              color: MyColor.redAT,
                            ),
                            label: Text(
                              "Daftar Pembayaran",
                              style:
                                  TextStyle(color: MyColor.redAT, fontSize: 14),
                            ),
                          ),
                        ),
                    if (orderDetail?.pembayaranKreditPro != null)
                      Card(
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Pembayaran Kredit",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  if (orderDetail?.pembayaranKreditPro?.image !=
                                      null)
                                    Image.network(
                                      orderDetail?.pembayaranKreditPro?.image,
                                      height: 24,
                                    ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: LinearPercentIndicator(
                                  lineHeight: 18,
                                  percent: orderDetail
                                          ?.pembayaranKreditPro?.percent ??
                                      0,
                                  center: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (false)
                                        Text(
                                          MyNumber.toNumberRpStr(orderDetail
                                                  ?.pembayaranKreditPro?.start
                                                  ?.toString() ??
                                              '0'),
                                          // style: TextStyle(fontSize: 14),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      Text(
                                        (orderDetail?.pembayaranKreditPro
                                                    ?.proses?.isNotEmpty ??
                                                false)
                                            ? orderDetail
                                                ?.pembayaranKreditPro?.proses
                                            : MyNumber.toNumberRpStr(orderDetail
                                                    ?.pembayaranKreditPro
                                                    ?.unPaid
                                                    ?.toString() ??
                                                '0'),
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
/*
                                  center: Text(
                                    orderDetail?.pembayaranKreditPro?.status ??
                                        '',
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.white),
                                  ),
*/
                                  backgroundColor: Colors.grey,
                                  progressColor: MyColor.mainGreen,
                                ),
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (false)
                                    Text(
                                      '(${orderDetail?.pembayaranKreditPro
                                          ?.status ?? ''}) ',
                                      style: TextStyle(
                                        // fontSize: 14.0, color: Colors.white),
                                          fontSize: 14.0),
                                    ),
                                  Text(
                                    MyNumber.toNumberRpStr(orderDetail
                                        ?.pembayaranKreditPro?.start
                                        ?.toString() ??
                                        '0'),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(' / '),
                                  Text(
                                    MyNumber.toNumberRpStr(orderDetail
                                        ?.pembayaranKreditPro?.end
                                        ?.toString() ??
                                        '0'),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
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
                                    fontSize: 14, color: MyColor.greyTextAT),
                              ),
                              Text(
                                orderDetail != null ? orderDetail.ringkasan
                                    .jumlahPesanan.toString() : "0",
                                style: TextStyle(
                                  fontSize: 14,
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
                                    fontSize: 14, color: MyColor.greyTextAT),
                              ),
                              Text(
                                orderDetail != null ? orderDetail.ringkasan
                                    .jumlahDiterima.toString() : "0",
                                style: TextStyle(
                                  fontSize: 14,
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
                                  fontSize: 14,
                                  color: MyColor.greyTextAT,
                                ),
                              ),
                              Text(
                                orderDetail != null ? orderDetail.ringkasan
                                    .sisaPesanan.toString() : "0",
                                style: TextStyle(
                                  fontSize: 14,
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
                                fontSize: 14, color: MyColor.greyTextAT),
                          ),
                          Text(
                            orderDetail != null
                                ? MyNumber.toNumberRpStr(
                                orderDetail.ringkasan.totalHarga.toString())
                                : "0",
                            style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    if(orderDetail != null)
                      if(orderDetail.ringkasan.discount != null)
                        Container(
                          height: 3,
                          color: Color(0xffEAEAEA),
                          margin: EdgeInsets.symmetric(vertical: 10),
                        ),
                    if(orderDetail != null)
                      if(orderDetail.ringkasan.discount != null)
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Promo",
                                style: TextStyle(
                                    fontSize: 14, color: MyColor.greyTextAT),
                              ),
                              Text(
                                orderDetail != null
                                    ? MyNumber.toNumberRpStr(
                                    orderDetail.ringkasan.discount.toString())
                                    : "0",
                                style: TextStyle(
                                    color: statusColor(
                                        orderDetail.ringkasan.labelDiscount),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),

                    if(orderDetail != null)
                      if(orderDetail.ringkasan.charge != null )
                        Container(
                          height: 3,
                          color: Color(0xffEAEAEA),
                          margin: EdgeInsets.symmetric(vertical: 10),
                        ),
                    if(orderDetail != null)
                      if(orderDetail.ringkasan.charge != null)
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                orderDetail.ringkasan.notifikasiCharge,
                                style: TextStyle(
                                    fontSize: 14, color: MyColor.greyTextAT),
                              ),
                              if (orderDetail.ringkasan.chargeThirdParty !=
                                  ' 0')
                                Text(
                                  orderDetail != null
                                      ? MyNumber.toNumberRpStr(orderDetail
                                          .ringkasan.chargeThirdParty
                                          .toString())
                                      : "0",
                                  style: TextStyle(
                                      color: statusColor(orderDetail
                                          .ringkasan.labelThirdParty),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              if (orderDetail.ringkasan.chargeThirdParty ==
                                  ' 0')
                                Text(
                                  orderDetail != null
                                      ? MyNumber.toNumberRpStr(orderDetail
                                          .ringkasan.charge
                                          .toString())
                                      : "0",
                                  style: TextStyle(
                                      color: statusColor(
                                          orderDetail.ringkasan.labelCharge),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
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
                                fontSize: 14, color: MyColor.greyTextAT),
                          ),
                          Text(
                            orderDetail != null ? MyNumber.toNumberRpStr(
                                orderDetail.ringkasan.totalPembayaran
                                    .toString()) : "0",
                            style: TextStyle(
                                color: MyColor.redAT,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
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
                            orderDetail != null ? orderDetail.pengiriman
                                .namaToko : "",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
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
                              orderDetail != null
                                  ? orderDetail.pengiriman.nama
                                  : "",
                              style: TextStyle(
                                  fontSize: 14, color: MyColor.greyTextAT),
                            ),
                          ),
                          Container(
                            child: Text(
                              " ",
                              style: TextStyle(
                                  fontSize: 14, color: MyColor.greyTextAT),
                            ),
                          ),
                          Container(
                            child: Text(
                              orderDetail != null
                                  ? orderDetail.pengiriman.noTlp
                                  : "",
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
                              orderDetail != null ? line2 : "",
                              style: TextStyle(
                                  fontSize: 14, color: MyColor.greyTextAT),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //tempat
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: orderDetail != null ? (orderDetail.pengiriman
                      .listDetailDelivery != null ? orderDetail.pengiriman
                      .listDetailDelivery.length : 0) : 0,
                  itemBuilder: (buildcontext, index) {
                    return _listDelivery(
                        orderDetail.pengiriman.listDetailDelivery[index]);
                  },
                ),
              ),
              //container
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
                      "(${orderDetail != null ? orderDetail.daftarBelanja
                          .jumlahBelanja : 0})",
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
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: orderDetail != null ? orderDetail.daftarBelanja
                      .listBelanja.length : 0,
                  // ignore: missing_return
                  itemBuilder: (buildcontext, index) {
                    if (orderDetail != null)
                      return listProduct.ListProductDetailOrderScreen(
                          orderDetail.daftarBelanja.listBelanja[index]);
                  },
                ),
              ),

              Container(
                height: 3,
                color: Color(0xffEAEAEA),
                margin: EdgeInsets.symmetric(vertical: 20),
              ),
              if(orderDetail?.detailPemesanan != null)
                if(orderDetail?.detailPemesanan?.statusPemesanan
                    ?.toLowerCase() == 'menunggu konfirmasi' ||
                    orderDetail?.detailPemesanan.ajukanKredit != null ||
                    orderDetail?.detailPemesanan.pilihMetodePembayaran !=
                        null ||
                    orderDetail?.detailPemesanan.konfirmasiPembayaran != null
                )
                  buttonDetailOrder()
            ],
          ),
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
          /*Stack(
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
          ),*/
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

  Widget _listDelivery(DetailDelivery detailDelivery){
    // debugPrint("cek =>${detailDelivery.listItemDetailDelivery}");
    return new Container(
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
                            fontSize: 14, color: MyColor.greyTextAT),
                      ),
                      Text(
                        detailDelivery.noSpj,
                        style: TextStyle(
                          fontSize: 14,
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
                            fontSize: 14, color: MyColor.greyTextAT),
                      ),
                      Text(
                        detailDelivery.statuPengiriman,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: statusColor(detailDelivery.labelStatus)),
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
                            fontSize: 14, color: MyColor.greyTextAT),
                      ),
                      Text(
                        detailDelivery.tanggalDikirim,
                        style: TextStyle(
                          fontSize: 14,
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
                            fontSize: 14, color: MyColor.greyTextAT),
                      ),
                      Text(
                        detailDelivery.dikirimOleh,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (detailDelivery?.konfirmasiPenerimaan != null)
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
                  Map<String, dynamic> param = {
                    'purchase': orderDetail.detailPemesanan,
                    'delivery': detailDelivery
                  };
                  Get.toNamed(confirmationAcceptScreen, arguments: param).then((
                      value) {
                    if (value != null) {
                      actionRefresh();
                    }
                  });
                },
              ),
            ),
          if(detailDelivery.konfirmasiBadQty != null )
            Container(
              margin:
              EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: 40,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: MyColor.redAT,
                borderRadius: BorderRadius.circular(30),
              ),
              child: FlatButton(
                child: Text(
                  "Konfirmasi Bad Qty",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                onPressed: () {
                  Map<String, dynamic> param = {
                    'purchase': orderDetail.detailPemesanan,
                    'delivery': detailDelivery
                  };
                  Get.toNamed(confirmationAcceptScreen, arguments: param).then((
                      value) {
                    if (value) {
                      actionRefresh();
                    }
                  });
                },
              ),
            ),
          Container(
            height: 3,
            color: Color(0xffEAEAEA),
            margin: EdgeInsets.symmetric(vertical: 5),
          ),
          ExpansionTile(
            /*onExpansionChanged: ,*/
            title: new Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Barang yang Dikirim",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            children: <Widget>[
              new Column(
                children: _buildExpandableContent(detailDelivery?.listItemDetailDelivery, detailDelivery.statuPengiriman),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildExpandableContent(List<ItemDetailDelivery> listItemDetailDelivery, String statusPengiriman) {
    List<Widget> columnContent = [];
    for (var i = 0 ; i < listItemDetailDelivery.length ; i++)
      columnContent.add(
          listProductShipment(listItemDetailDelivery[i], statusPengiriman)
      );
    return columnContent;
  }

  Widget listProductShipment(ItemDetailDelivery itemDetailDelivery, String statusPengiriman) {
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
      child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      itemDetailDelivery.namaProduct,
                      style: TextStyle(
                          fontSize: 14,
                          color: MyColor.redAT,
                          fontWeight: FontWeight.bold),
                    ),
                    Flexible(child: Container()),
                    Text(
                      itemDetailDelivery.kodeProduct,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Jumlah",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Flexible(child: Container()),
                    Text(
                      "${itemDetailDelivery.jumlah} ${itemDetailDelivery
                          .satuan}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: MyColor.blackTextAT,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              if (statusPengiriman.toLowerCase() == 'barang diterima')
                SizedBox(width: 5),
              if (statusPengiriman.toLowerCase() == 'barang diterima')
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Baik",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Flexible(child: Container()),
                      Text(
                        "${itemDetailDelivery.baik} ${itemDetailDelivery
                            .satuan}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: MyColor.blackTextAT,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              if (statusPengiriman.toLowerCase() == 'barang diterima')
                SizedBox(width: 5),
              if (statusPengiriman.toLowerCase() == 'barang diterima')
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Rusak",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Flexible(child: Container()),
                      Text(
                        "${itemDetailDelivery.buruk} ${itemDetailDelivery
                            .satuan}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: MyColor.blackTextAT,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            ],
          )),
    );
  }

  Widget buttonDetailOrder(){
    debugPrint("pilih pembayaran : ${orderDetail?.detailPemesanan?.toJson()}");
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: (orderDetail?.detailPemesanan?.statusPemesanan.toLowerCase() ==
            'menunggu konfirmasi' ? MyColor.orangeAT : MyColor.successTextAT),
        borderRadius: BorderRadius.circular(30),
      ),
      child: FlatButton(
        child: Text(
            textButton(),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14)
        ),
        onPressed: () {
          if (orderDetail?.detailPemesanan?.statusPemesanan.toLowerCase() ==
              'menunggu konfirmasi') {
            createAlertDialog(
                context,
                (orderDetail != null ? orderDetail.detailPemesanan
                    .idPemesanan : 0),
                "Apakah Anda yakin membatalkan pesanan ini?",
                3
            );
          } else if (orderDetail?.detailPemesanan.ajukanKredit != null) {
            actionPostUrlKreditPro(orderDetail.detailPemesanan
                .idPemesanan);
          } else
          if (orderDetail?.detailPemesanan.konfirmasiPembayaran != null) {
            Get.toNamed(addPaymentScreen,
                arguments: orderDetail.detailPemesanan
                    .idPemesanan).then((value) {
              if (value != null && value) {
                getListOrder();
              }
            }
            );
          } else
          if (orderDetail?.detailPemesanan.pilihMetodePembayaran != null) {
            toPaymentScreent();
          }
        },
      ),
    );
  }

  createAlertDialog(BuildContext context, String idPurchase, String message, int type, {String title = "Batalkan Pesanan"}) {
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
                    title,
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
                          message,
                          style: TextStyle(fontSize: 14),
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
                          onPressed: () {
                            Navigator.pop(context);
                            showDialogLoader(idPurchase, type);
                          },
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
}
