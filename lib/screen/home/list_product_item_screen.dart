import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/main.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:aksestokomobile/view_model/home/select_product_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/services.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ListProductScreen extends StatefulWidget {
  final Product _product;
  final SelectProductController controller;
  final SelectProductViewModel vm;

  ListProductScreen(this._product, this.controller, this.vm);

  _ListProductScreenState createState() =>
      _ListProductScreenState(_product, controller, vm);
}

class _ListProductScreenState extends State<ListProductScreen> {
  TextEditingController _controller = TextEditingController();
  final SelectProductController controller;
  final SelectProductViewModel vm;
  final Product _product;
  FocusNode _focusNode = FocusNode();

  _ListProductScreenState(this._product, this.controller, this.vm);

  _actionUpdateData() {
    if (!_focusNode.hasFocus) {
      double newValue = double.tryParse(_controller.text ?? 0.0) ?? 0.0;
      _product.countChange = 1;
      int multiple = _product?.isMultiple == 1 ? 1 : 0;
      int minQty = _product?.minOrder ?? 1;
      minQty = minQty == 0 ? 1 : minQty;
      if (newValue <= 0) {
        _showAlertDialog(context, controller, _product);
      } else {
        var add = minQty - (newValue % minQty);
        newValue += (add % minQty) * (newValue < minQty ? 1 : multiple);
        controller.addToCart(_product, customQty: newValue);
      }
    } else {
      controller?.currentFocus = _focusNode;
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode?.addListener(() {
      if (mounted) _actionUpdateData();
    });
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
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
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 112,
                    width: 112,
                    child: (_product?.imageUrl?.isEmpty ?? true) || isDebugOnly
                        ? Image.asset(kNoImage, height: 112)
                        : FadeInImage.assetNetwork(
                            placeholder: kNoImage,
                            image: _product?.imageUrl ?? '',
                            fit: BoxFit.cover,
                            width: 112,
                          ),
                  ),
                ),
                if ((_product?.minOrder ?? 0) > 0)
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Text(
                        'minQty: ${_product?.minOrder}${_product?.isMultiple == 1 ? '×' : ''}'),
                  ),
              ],
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
                _product.kodeUnit ?? '',
                style: TextStyle(
                  color: Color(0xff999999),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 5),
            Flexible(child: Container()),
            Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  '${MyNumber.toNumberRpStr(_product.satuanHargaCash.toString())}',
                  style: TextStyle(
                    color: Color(0xffB20838),
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 30,
                    width: 30,
                    child: MaterialButton(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(7),
                      color: Color(0xFF387C2B),
                      onPressed: () {
                        int minQty = _product?.minOrder ?? 1;
                        minQty = minQty < 1 ? 1 : minQty;
                        int currentValue =
                        (_product.qty != null ? _product.qty : 0).toInt();
                        _product.countChange = 1;
                        if (currentValue <= minQty) {
                          _showAlertDialog(context, controller, _product);
                        } else {
                          int multiple = _product?.isMultiple ?? 0;
                          int min = multiple == 0 ? 1 : (multiple * minQty);
                          currentValue -= min;
                          controller.reduceCart(_product,
                              customQty: currentValue.toDouble());
                        }
                      },
                      child:
                      Icon(Icons.remove, size: 16, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: TextFormField(
                        focusNode: _focusNode,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.bold,
                        ),
                        maxLength: 8,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          border: InputBorder.none,
                          isDense: true,
                          counterText: '',
                        ),
                        controller: _controller,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: false,
                          signed: true,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    child: MaterialButton(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(7),
                      color: Color(0xFF387C2B),
                      onPressed: () {
                        int minQty = _product?.minOrder ?? 1;
                        int currentValue =
                        (_product.qty != null ? _product.qty : 0).toInt();
                        if (currentValue < minQty) {
                          currentValue = minQty;
                        } else {
                          int multiple = _product?.isMultiple ?? 0;
                          int add = multiple == 0 ? 1 : (multiple * minQty);
                          currentValue += add;
                        }
                        _product.countChange = 1;
                        controller.addToCart(_product,
                            customQty: currentValue.toDouble());
                      },
                      child: Icon(Icons.add, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _actionDelete(Product product) async {
    if (product == null) return;
    if (product.idCart == null) {
      controller.removeCart(_product);
      Get.back();
      return;
    }
    var fields = {
      'id_distributor': MyPref.getIdDistributor(),
      'id_cart': product?.idCart,
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlDeleteItemCart,
      fields,
      {},
      customHandle: true,
      onSuccess: (data, _) {
        controller.removeCart(_product);
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
      onAfter: (status) {
        Get.back();
      },
    );
    status.execute();
  }

  void _showAlertDialog(BuildContext context,
      SelectProductController controller, Product _product) {
    if ((_product?.qty ?? 0) == 0) return;
    Widget cancelButton = FlatButton(
      child: Text("Batal"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget launchButton = FlatButton(
      child: Text("YA"),
      onPressed: () {
        _actionDelete(_product);
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
