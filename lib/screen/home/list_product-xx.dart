import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/Product.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:aksestokomobile/view_model/home/select_product_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/services.dart';

class ListProductScreen extends StatefulWidget {
  final Product _product;
  final SelectProductController controller;
  final SelectProductViewModel vm;
  ListProductScreen(this._product, this.controller, this.vm);
  _ListProductScreenState createState() => _ListProductScreenState(_product, controller, vm);
}

class _ListProductScreenState extends State<ListProductScreen> {
  TextEditingController _controller = TextEditingController();
  final SelectProductController controller;
  final SelectProductViewModel vm;
  final Product _product;
  _ListProductScreenState(this._product, this.controller, this.vm);
  @override
  void initState() {
    super.initState();
    _controller.text = _product.qty != null ? _product.qty.toString() : '0'; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        //color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                //color: Colors.blue,
                child: Image.asset(
                  kImageDynamix,
                  height: 100,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '${_product.qty} => ${_product.nama}',
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
                      '${MyNumber.toNumberRpStr(_product.satuanHargaCash)}',
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
                            /*vm.confirmMinus();*/
                            int currentValue = (_product.qty != null ? _product.qty : 0).toInt();
                            currentValue --;
                            if(currentValue > 0){
                              _controller.text =currentValue.toString();
                              controller.reduceCart(_product, customQty: currentValue.toDouble());
                            }else{
                              _showAlertDialog(context, controller, _product);
                            }
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
                          /*initialValue: 'wkwk',*/
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
                            int currentValue = (_product.qty != null ? _product.qty : 0).toInt();
                            currentValue++;
                            controller.addToCart(_product, customQty: currentValue.toDouble());
                            _controller.text = (currentValue).toString();
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

  void _showAlertDialog(BuildContext context, SelectProductController controller, Product _product) {
    // set up the buttons

    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget launchButton = FlatButton(
      child: Text("Launch missile"),
      onPressed:  () {
        controller.removeCart(_product);
        _controller.text = '0';
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content: Text("Apakah Anda Yakin Menghapus Barang Ini ?"),
      actions: [
        cancelButton,
        launchButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
