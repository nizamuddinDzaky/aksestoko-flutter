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

class DetailOrderScreen extends StatefulWidget {
  _DetailOrderScreenState createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends DetailOrderViewModel {
  @override
  Widget build(BuildContext context) {
    /*debugPrint("sad => ${orderDetail.pengiriman.listDetailDelivery.length}");*/
    var index = Get.arguments;
    // debugPrint("index = ${orderDetail.detailPemesanan}");
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
                                    fontSize: 14, color: MyColor.greyTextAT),
                              ),
                              Text(
                                orderDetail != null ? orderDetail.detailPemesanan.noPemesanan :  "",
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
                                "ID Bisnis Kokoh",
                                style: TextStyle(
                                    fontSize: 14, color: MyColor.greyTextAT),
                              ),
                              Text(
                                orderDetail != null ? orderDetail.detailPemesanan.idBk :  "",
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
                                orderDetail != null ? orderDetail.detailPemesanan.tanggalPeesanan :  "",
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
                                "Tgl Ekspetasi Pengiriman",
                                style: TextStyle(
                                    fontSize: 14, color: MyColor.greyTextAT),
                              ),
                              Text(
                                orderDetail != null ? orderDetail.detailPemesanan.ekpestasi :  "",
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
                                orderDetail != null ? orderDetail.detailPemesanan.kodeDistributor :  "",
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
                                "Nama Distributor",
                                style: TextStyle(
                                    fontSize: 14, color: MyColor.greyTextAT),
                              ),
                              Text(
                                orderDetail != null ? orderDetail.detailPemesanan.namaDistributor :  "",
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
                                orderDetail != null ? orderDetail.detailPemesanan.caraPengiriman :  "",
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
                                "Cara Pembayaran",
                                style: TextStyle(
                                    fontSize: 14, color: MyColor.greyTextAT),
                              ),
                              Text(

                                orderDetail != null ? orderDetail.detailPemesanan.caraPembayaran :  "",
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
                                    fontSize: 14, color: MyColor.greyTextAT),
                              ),
                                Text(
                                  orderDetail != null ? orderDetail.detailPemesanan.statusPemesanan :  "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor(orderDetail != null ? orderDetail.detailPemesanan.notifikasiPemesanan :  ""),
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
                                    fontSize: 14, color: MyColor.greyTextAT),
                              ),
                              /*if (index == 0)*/
                                Text(
                                  orderDetail != null ? orderDetail.detailPemesanan.statusPembayaran :  "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor(orderDetail != null ? orderDetail.detailPemesanan.notifikasiPembayaran :  ""),
                                  ),
                                ),
                              /*if (index == 1)
                                Text(
                                  "Diterima Sebagian",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: MyColor.infoAT,
                                  ),
                                ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(orderDetail != null )
                  if (orderDetail.detailPemesanan.daftarPembayaran != null)
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
                          style: TextStyle(color: MyColor.redAT, fontSize: 14),
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
                              orderDetail != null ? orderDetail.ringkasan.jumlahPesanan.toString() : "0",
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
                              orderDetail != null ? orderDetail.ringkasan.jumlahDiterima.toString() : "0",
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
                              orderDetail != null ? orderDetail.ringkasan.sisaPesanan.toString() : "0",
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
                            orderDetail != null ? MyNumber.toNumberRpStr(orderDetail.ringkasan.totalHarga.toString()) : "0",
                          style: TextStyle(
                              color: MyColor.blackTextAT,
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
                            orderDetail != null ? MyNumber.toNumberRpStr(orderDetail.ringkasan.totalPembayaran.toString()) : "0",
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
                          orderDetail != null ? orderDetail.pengiriman.namaToko : "",
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
                            orderDetail != null ? orderDetail.pengiriman.nama : "",
                            style: TextStyle(
                                fontSize: 14, color: MyColor.greyTextAT),
                          ),
                        ),
                        Container(
                          child: Text(
                              orderDetail != null ? orderDetail.pengiriman.noTlp : "",
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
                            orderDetail != null ? orderDetail.pengiriman.alamat : "",
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
                itemCount: orderDetail != null ? (orderDetail.pengiriman.listDetailDelivery != null ? orderDetail.pengiriman.listDetailDelivery.length : 0)  : 0,
                itemBuilder: (buildcontext, index) {
                  return _listDelivery(orderDetail.pengiriman.listDetailDelivery[index]);
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
                    "(${orderDetail != null ? orderDetail.daftarBelanja.jumlahBelanja : 0})",
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
                itemCount: orderDetail != null ? orderDetail.daftarBelanja.listBelanja.length : 0,
                itemBuilder: (buildcontext, index) {
                  if(orderDetail != null)
                    return listProduct.ListProductDetailOrderScreen(orderDetail.daftarBelanja.listBelanja[index]);
                },
              ),
            ),

              Container(
                height: 3,
                color: Color(0xffEAEAEA),
                margin: EdgeInsets.symmetric(vertical: 20),
              ),
            if (orderDetail != null && orderDetail.detailPemesanan.statusPemesanan.toLowerCase() == 'menunggu konfirmasi')
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
                    createAlertDialog(context, (orderDetail !=null ? orderDetail.detailPemesanan.idPemesanan : 0));
                  },
                ),
              ),
            if (orderDetail != null && orderDetail.detailPemesanan.konfirmasiPembayaran != null)
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: MyColor.successTextAT,
                borderRadius: BorderRadius.circular(30),
              ),
              child: FlatButton(
                child: Text(
                  "Selesaikan Pembayaran",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () {
                  // createAlertDialog(context);
                },
              ),
            )
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
          if(detailDelivery.statuPengiriman.toLowerCase() == 'dalam pengiriman')
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
                Map<String, dynamic> param = {
                  'purchase': orderDetail.detailPemesanan,
                  'delivery': detailDelivery
                };
                Get.toNamed(confirmationAcceptScreen, arguments: param);
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
                children: _buildExpandableContent(detailDelivery.listItemDetailDelivery),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildExpandableContent(List<ItemDetailDelivery> listItemDetailDelivery) {
    List<Widget> columnContent = [];
    for (var i = 0 ; i < listItemDetailDelivery.length ; i++)
      columnContent.add(
          listProductShipment(listItemDetailDelivery[i])
      );
    return columnContent;
  }

  Widget listProductShipment(ItemDetailDelivery itemDetailDelivery) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  itemDetailDelivery.namaProduct,
                  style: TextStyle(
                      fontSize: 14,
                      color: MyColor.redAT,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  itemDetailDelivery.kodeProduct,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Jumlah",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  "${itemDetailDelivery.jumlah} ${itemDetailDelivery.satuan}",
                  style: TextStyle(
                    fontSize: 14,
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

  createAlertDialog(BuildContext context, String idPurchase) {
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
                            showDialogProgress(idPurchase);
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
