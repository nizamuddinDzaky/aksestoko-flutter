import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/services.dart';

class ListProductScreen extends StatefulWidget {
  final Product _product;
  final SelectProductController controller;
  ListProductScreen(this._product, this.controller);
  _ListProductScreenState createState() => _ListProductScreenState(_product, controller);
}

class _ListProductScreenState extends State<ListProductScreen> {
  TextEditingController _controller = TextEditingController();
  final SelectProductController controller;

  final Product _product;
  _ListProductScreenState(this._product, this.controller);
  @override
  void initState() {
    super.initState();
    _controller.text = "0"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        //color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                //color: Colors.blue,
                child: Image.asset(
                  kImageDynamix,
                  height: 140,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                _product.nama,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      _product.satuanHargaCash,
                      style: TextStyle(
                        color: Color(0xffB20838),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' / ${_product.kodeUnit}',
                      style: TextStyle(
                        color: Color(0xff999999),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 10),
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: FlatButton(
                      color: Color(0xFF387C2B),
                      onPressed: () {
                        int currentValue = int.parse(_controller.text);
                        setState(() {
                          print("tes minus");
                          currentValue--;
                          _controller.text =
                              (currentValue > 0 ? currentValue : 0).toString();
                        });
                      },
                      shape: CircleBorder(),
                      child: Text(
                        '-',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 50,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                      ),
                      controller: _controller,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: false,
                        signed: true,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: FlatButton(
                      color: Color(0xFF387C2B),
                      onPressed: () {
                        int currentValue = int.parse(_controller.text);
                        controller.addToCart(_product, customQty: currentValue.toDouble());
                        setState(() {
                          currentValue++;
                          _controller.text = (currentValue).toString();
                        });
                      },
                      shape: CircleBorder(),
//                      padding: EdgeInsets.all(5),
                      child: Text(
                        '+',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
