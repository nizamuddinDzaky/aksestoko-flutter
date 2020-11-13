import 'package:aksestokomobile/util/my_number.dart';
import 'package:aksestokomobile/view_model/order/detail_payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/screen/order/list_payment_screen.dart'
    as listPayment;

class DetailPaymentScreen extends StatefulWidget {
  _DetailPaymentScreenState createState() => _DetailPaymentScreenState();
}

class _DetailPaymentScreenState extends DetailPaymentViewModel {

  @override
  void initState() {
    actionRefresh();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var formLayout =
        completeLoad == null
    ? Center(child: CircularProgressIndicator()) :
    SingleChildScrollView(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: ListView.builder(
                itemCount: detailPayment.listPembayaran.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (buildcontext, index) {
                  return listPayment.ListPaymentScreen(detailPayment.listPembayaran[index], index);
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
        centerTitle: true,
        title: Hero(
          tag: 'logoForcaPoS',
          child: Text("Detail Pembayaran"),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: formLayout,
      ),
      bottomNavigationBar: completeLoad == null
          ? Center(child: CircularProgressIndicator()) : new Stack(
        overflow: Overflow.visible,
        children: [
          new Container(
            padding: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0, 9), // changes position of shadow
                )
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Total Bayar",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        detailPayment != null ? MyNumber.toNumberRpStr(detailPayment.totalPembayaran.toString()) : "Rp 0",
                        style: TextStyle(
                            color: MyColor.greenAT,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Total Belanja",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        detailPayment != null ? MyNumber.toNumberRpStr(detailPayment.jumlahYangHarusDibayar.toString()) : "Rp 0",
                        style: TextStyle(
                            color: MyColor.redAT,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
