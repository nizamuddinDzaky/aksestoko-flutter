import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:aksestokomobile/view_model/home/select_product_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/services.dart';
import 'package:aksestokomobile/util/my_util.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = _product?.qty?.toString()?.toNumId() ?? '0';
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
                  height: 120,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '${_product.nama}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '${_product.kodeUnit}',
                style: TextStyle(
                  color: Color(0xff999999),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  '${MyNumber.toNumberRpStr(_product.satuanHargaCash)}',
                  style: TextStyle(
                    color: Color(0xffB20838),
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(height: 10),
            Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Container(
                    height: 30,
                    width: 30,
                    child: FittedBox(
                      child: FloatingActionButton(
                        heroTag: "btnMinus${_product.nama}",
                        backgroundColor: Color(0xFF387C2B),
                        onPressed: () {
                          int currentValue = (_product.qty != null ? _product.qty : 0).toInt();
                          currentValue --;
                          if(currentValue > 0){
                            _controller.text =currentValue.toString();
                            controller.reduceCart(_product, customQty: currentValue.toDouble());
                          }else{
                            _showAlertDialog(context, controller, _product);
                          }
                        },
                        child: Icon(Icons.remove),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // height: 40,
                      // width: 50,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Color(0xFF333333),
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          border: InputBorder.none,
                        ),
                        controller: _controller,
                        keyboardType: TextInputType.numberWithOptions(decimal: false, signed: true,),
                        inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    child: FittedBox(
                      child: FloatingActionButton(
                        heroTag: "btnPlus${_product.nama}",
                        backgroundColor: Color(0xFF387C2B),
                        onPressed: () {
                          int currentValue = (_product.qty != null ? _product.qty : 0).toInt();
                          currentValue++;
                          controller.addToCart(_product, customQty: currentValue.toDouble());
                          _controller.text = (currentValue).toString();
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
              ],
            ),
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
      child: Text("Batal"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget launchButton = FlatButton(
      child: Text("YA"),
      onPressed:  () {
        controller.removeCart(_product);
        _controller.text = '0';
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Perhatian"),
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
