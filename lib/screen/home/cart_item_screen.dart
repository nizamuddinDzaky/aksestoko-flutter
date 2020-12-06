import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CartItemScreen extends StatefulWidget {
  final Product product;

  CartItemScreen(this.product);

  @override
  _CartItemScreenState createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
  TextEditingController _qtyTextController = TextEditingController();
  SelectProductController controller = Get.find();
  FocusNode _focusNode = FocusNode();

  String count(String unitPrice, double qty) {
    var price = MyNumber.strUSToDouble(unitPrice);
    var total = price * qty;
    return "${MyNumber.toNumberRpStr(total.toString())}";
  }

  reInitText() {
    setState(() {
      _qtyTextController.text = widget.product.qty.toInt().toString();
    });
  }

  _actionUnFocus() {
    if (!_focusNode.hasFocus) {
      controller.actionUpdate(
        widget.product,
        0,
        onRefresh: () {
          reInitText();
        },
        cusQty: int.tryParse(_qtyTextController.text) ?? widget.product.qty,
      );
    } else {
      controller?.currentFocus = _focusNode;
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint('init cart item ${widget.product.qty}');
    _qtyTextController.text = widget.product.qty.toInt().toString();
    _focusNode.addListener(() {
      _actionUnFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: IntrinsicHeight(
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: MyColor.greyAT,
                            width: 3.0,
                          ),
                        ),
                      ),
                      height: 40,
                      margin: EdgeInsets.only(top: 5, left: 0, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Checkbox(
                          //   value: CheckBoxValue,
                          //   onChanged: (bool value) {
                          //     setState(() {
                          //       CheckBoxValue = value;
                          //     });
                          //   },
                          // ),
                          SizedBox(width: 8),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: MyColor.redAT,
                                size: 20,
                              ),
                              onPressed: () {
                                controller.openDialog(context,
                                    step: 1, data: widget.product);
                              }),
                        ],
                      ),
                      alignment: Alignment(-1.0, 0.0),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 120,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 112,
                        width: 90,
                        child: kDebugMode
                            ? Image.asset(kNoImage, height: 112)
                            : FadeInImage.assetNetwork(
                                placeholder: kNoImage,
                                image: widget?.product?.imageUrl ?? '',
                                fit: BoxFit.cover,
                                width: 90,
                              ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(children: [
                          Container(
                              height: 70,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.product.nama ?? '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff333333),
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          widget.product.kodeUnit ?? '',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Container(
                            height: 40,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          'Harga',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: 14),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '${MyNumber.toNumberRpStr(
                                              widget.product.satuanHargaCash
                                                  .toString())}',
                                          style: TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            height: 20,
                                            width: 20,
                                            child: FittedBox(
                                              child: MaterialButton(
                                                shape: CircleBorder(),
                                                padding: EdgeInsets.all(8),
                                                color: Color(0xFF387C2B),
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 54,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  controller.actionUpdate(
                                                    widget.product,
                                                    -1,
                                                    onRefresh: () {
                                                      reInitText();
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 50,
                                            child: TextFormField(
                                              focusNode: _focusNode,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF333333),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(0.0),
                                                border: InputBorder.none,
                                              ),
                                              controller: _qtyTextController,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                decimal: false,
                                                signed: true,
                                              ),
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            child: FittedBox(
                                              child: MaterialButton(
                                                shape: CircleBorder(),
                                                padding: EdgeInsets.all(8),
                                                color: Color(0xFF387C2B),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 54,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  debugPrint(
                                                      "${_qtyTextController.text}");
                                                  int currentValue = widget
                                                      .product.qty
                                                      .toInt();
                                                  widget.product.qty =
                                                      currentValue.toDouble();
                                                  controller.actionUpdate(
                                                    widget.product,
                                                    1,
                                                    onRefresh: () {
                                                      reInitText();
                                                    },
                                                  );
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ]),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: MyColor.greyAT,
                      width: 3.0,
                    ),
                  ),
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "SUBTOTAL",
                        style: TextStyle(
                          color: Color(0xff999999),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
/*
                      Text(
                        // widget.product.idCart?.toString() ?? '',
                        widget.product.countChange?.toString() ?? '',
                        style: TextStyle(
                          color: Color(0xff999999),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
*/
                      Text(
                        count(
                            widget.product.satuanHargaCash.toString(), widget.product.qty),
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
