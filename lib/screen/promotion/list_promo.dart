import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ListPromoScreen extends StatefulWidget {
  @override
  _ListPromoScreenState createState() => _ListPromoScreenState();
}
class _ListPromoScreenState extends State<ListPromoScreen> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    controller = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Container(
            //color: Colors.white,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Text(
                "Pemesanan",
                style: TextStyle(fontSize: 20),
              )
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
                    /*Get.toNamed(cartScreen).then((value){
                      setState(() {});
                    });*/
                  },
                ),
                  Positioned(
                    right: 5,
                    top: 4,
                    child: CircleAvatar(
                      maxRadius: 10,
                      backgroundColor: MyColor.redAT,
                      child: Text(
                        '0',
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
        /*child: _body(vm),*/
      ),
    );
  }
}