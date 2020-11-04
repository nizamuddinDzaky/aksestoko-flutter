import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/model/delivery.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:aksestokomobile/view_model/order/preview_delivery_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviewDeliveryScreen extends StatefulWidget {
  String idPurchase;
  PreviewDeliveryScreen(String idPurchase){
    this.idPurchase = idPurchase;
  }
  @override
  _PreviewDeliveryScreenState createState() => _PreviewDeliveryScreenState(idPurchase);
}

class _PreviewDeliveryScreenState extends PreviewDeliveryViewModel {
  String idPurchase;
  _PreviewDeliveryScreenState(String idPurchase){
    this.idPurchase = idPurchase;
  }
  @override
  void initState() {
    super.initState();
    actionRefresh(idPurchase);
  }
  Widget _delivery(DetailDelivery detailDelivery){
    return new Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(left: 0, right: 0, top: 10),
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
                        detailDelivery?.noSpj,
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
                        detailDelivery?.statuPengiriman,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: statusColor(detailDelivery?.labelStatus)),
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
                        detailDelivery?.tanggalDikirim,
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
                        detailDelivery?.dikirimOleh,
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
            margin:
            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            height: 40,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: MyColor.greenAT,
              borderRadius: BorderRadius.circular(30),
            ),
            child: FlatButton(
              child: Text(
                "Terima",
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
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => _delivery(listDetailDelivery[index]),
      itemCount: listDetailDelivery.length,
    );
  }
}