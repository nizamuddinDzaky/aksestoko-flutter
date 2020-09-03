//import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/controller/home/select_distributor_controller.dart';
import 'package:aksestokomobile/model/Distributor.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
//import 'package:get/get.dart';
import 'package:aksestokomobile/screen/home/parent_screen.dart';
import 'package:get/get.dart';
class ListDistributorScreen extends SelectDistributorController {

  listItem(BuildContext context, Distributor distributor, int index){
    return Card(
      elevation: 2,
      child: InkWell(
        child: Container(
          child: Row(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Image.asset(kDistributor),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          distributor.nama,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff999999),
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        child: Text(
                          distributor.alamatLengkap,
                          style:
                          TextStyle(color: Color(0xff999999), fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Text(
                          distributor.noTlpn,
                          style:
                          TextStyle(color: Color(0xff999999), fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () async {
          await gotoParent(context, distributor);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  /*@override
  Widget build(BuildContext context) {

  }*/
}
