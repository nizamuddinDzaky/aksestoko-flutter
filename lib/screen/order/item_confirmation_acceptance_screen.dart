import 'package:aksestokomobile/controller/order/confirmation_acceptance_controller.dart';
import 'package:aksestokomobile/model/delivery.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemConfirmationAcceptScreen extends StatefulWidget {
  int index;
  ItemDetailDelivery itemDetailDelivery;
  ItemConfirmationAcceptScreen(ItemDetailDelivery itemDetailDelivery){
    this.itemDetailDelivery = itemDetailDelivery;
    // this.index = index;
  }
  _ItemConfirmationAcceptScreen createState() => _ItemConfirmationAcceptScreen(itemDetailDelivery);
}

class _ItemConfirmationAcceptScreen extends State<ItemConfirmationAcceptScreen> {

  TextEditingController baikControllerText = TextEditingController();
  TextEditingController badControllerText = TextEditingController();

  FocusNode _focus = new FocusNode();
  int i;
  ConfirmationAcceptanceController controller = Get.find();
  ItemDetailDelivery itemDetailDelivery;
  _ItemConfirmationAcceptScreen(ItemDetailDelivery itemDetailDelivery){
    this.itemDetailDelivery = itemDetailDelivery;
    // this.itemDetailDelivery = controller.detailDelivery.listItemDetailDelivery[index];
  }

  @override
  void initState() {

    baikControllerText.text = (itemDetailDelivery.baik ?? itemDetailDelivery.jumlah).toString();
    badControllerText.text = (itemDetailDelivery.buruk ?? 0).toString();
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  void _onFocusChange(){
    if(!_focus.hasFocus){
      debugPrint("asdsad :${badControllerText.text != '' ? 'asdsad' : 0}");
      int crntVal = int.parse(badControllerText.text != '' ? badControllerText.text : "0");
      if(crntVal > itemDetailDelivery.jumlah){
        itemDetailDelivery.baik = 0;
        itemDetailDelivery.buruk = itemDetailDelivery.jumlah;
      }else{
        itemDetailDelivery.baik = itemDetailDelivery.jumlah - crntVal;
        itemDetailDelivery.buruk = crntVal;
      }

      controller.updateScreen();
      setState(() {
        baikControllerText.text = (itemDetailDelivery.baik ?? itemDetailDelivery.jumlah).toString();
        badControllerText.text = (itemDetailDelivery.buruk ?? 0).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: MyColor.redAT,
                ),
                child: Text(
                  "S",
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      itemDetailDelivery.namaProduct,
                      style: TextStyle(
                          color: MyColor.redAT,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      itemDetailDelivery.kodeProduct,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                    Row(
                      children: <Widget>[
                        Text(
                          itemDetailDelivery.jumlah.toString(),
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.left,
                        ),
                        Padding(padding: EdgeInsets.only(left: 4)),
                        Text(
                          itemDetailDelivery.satuan,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 3,
            color: Color(0xffEAEAEA),
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Barang Baik"),
                    Padding(padding: EdgeInsets.all(5)),
                    TextField(
                      controller: baikControllerText,
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffEEEEEE),
                        hintText: "100",
                        contentPadding: const EdgeInsets.only(left: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffC8C8C8), width: 1.0),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: MyColor.redAT, width: 1),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Barang Rusak"),
                    Padding(padding: EdgeInsets.all(5)),
                    TextField(
                      controller: badControllerText,
                      focusNode: _focus,
                      keyboardType: TextInputType.number,
                      /*onChanged: (String value){
                        itemDetailDelivery.buruk = 40;
                      },*/
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffEEEEEE),
                        hintText: "100",
                        contentPadding: const EdgeInsets.only(left: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffC8C8C8), width: 1.0),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: MyColor.redAT, width: 1),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}