import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/Product.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:aksestokomobile/view_model/home/select_product_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/screen/home/list_product_item_screen.dart';

class SelectProductScreen extends StatefulWidget {
  @override
  _SelectProductScreenState createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends SelectProductViewModel {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectProductController>(
      init: SelectProductController(),
        builder: (vm) =>Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Container(
              //color: Colors.white,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: TextField(
                style: TextStyle(textBaseline: TextBaseline.alphabetic),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 15.0),
                  hintText: 'Cari Produk',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            centerTitle: false,
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
              Stack(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Get.toNamed(cartScreen).then((value){
                        setState(() {
                          debugPrint("refresh");
                        });
                      });
                    },
                  ),
                  if (vm.listCart?.isNotEmpty ?? false)
                  Positioned(
                    right: 5,
                    top: 4,
                    child: CircleAvatar(
                      maxRadius: 10,
                      backgroundColor: MyColor.redAT,
                      child: Text(
                        '${vm.listCart?.length ?? '0'}',
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
            child: _body(vm),
          ),
          floatingActionButton: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric( horizontal: 15, vertical: 10 ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: MyColor.greyTextAT,
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset:
                  Offset(0, 2), // changes position of shadow
                )
              ],
            ),
            child: FloatingActionButton.extended(
              onPressed: () {
                if(vm.listCart == null || vm.listCart.length < 1){
                  _alertDialog();
                }else{
                  Get.toNamed(checkoutScreen);
                }
              },
              backgroundColor: MyColor.greenAT,
              icon: Icon(Icons.payment),
              label: Text(
                "Lanjutkan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        )
    );
  }

  Widget _gridProduct(SelectProductController controller){
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = 270;
    final double itemWidth = size.width / 2;
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 20,
        childAspectRatio: (itemWidth / itemHeight),
      ),
      padding: EdgeInsets.only(top: 10),
      physics: NeverScrollableScrollPhysics(),
      itemCount: listProduct.length,
      itemBuilder: (context, index)=>ListProductScreen(listProduct[index], controller, this),
    );
  }

  Widget _body(SelectProductController controller){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 20),
            width: MediaQuery.of(context).size.width * 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgHeaderTop),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Daftar Produk',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      MyPref.getDistributorName().isNotEmpty ?MyPref.getDistributorName() : "Silahkan Pilih Distributor",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      onPressed: () {
                        /*setState((){
                          MyPref.logout();
                        });*/
                        Get.toNamed(selectDistributorScreen).then((value) {
                          getDataProduct();
                          getDataCart();
                        });
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.only(bottom: 100),
            child: !MyPref.isIdDistributorExist() ?
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return new Text('Silahkan Pilih Distributor');
                }
            ): _gridProduct(controller),
          ),
        ],
      ),
    );
  }

  void _alertDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Perhatian"),
          content: new Text("Keranjang masih kosong. Silahkan pilih produk."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Tutup"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /*void _showAlertDialog(BuildContext context, SelectProductController controller, Product _product) {
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
  }*/
}
