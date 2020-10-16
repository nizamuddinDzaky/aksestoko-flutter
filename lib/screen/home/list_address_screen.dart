import 'package:aksestokomobile/model/alamat.dart';
import 'package:aksestokomobile/screen/account/address_controller.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:get/get.dart';

class ListAddressScreen extends StatefulWidget {
  AddressController controller;

  ListAddressScreen(AddressController controller) {
    this.controller = controller;
  }

  @override
  _ListAddressScreenState createState() => _ListAddressScreenState(controller);
}

class _ListAddressScreenState extends State<ListAddressScreen> {
  AddressController controller;

  _ListAddressScreenState(AddressController controller) {
    this.controller = controller;
  }

  @override
  void initState() {
    super.initState();
    controller.getListAddress();
  }

  Widget _address(Alamat address) {
    List<String> line1 = [
      address?.addressName,
      address?.addressPhone,
    ];
    List<String> line2 = [
      address?.address,
      address?.addressPostalCode,
    ];
    return InkWell(
      onTap: () {
        Get.back(result: address);
        debugPrint("ok");
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: MyColor.greyTextAT,
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            )
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.location_on,
                          color: MyColor.redAT,
                          size: 20,
                        ),
                      ),
                      Text(
                        address != null ? "${address.addressName}" : "",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 20,
                            color: MyColor.redAT,
                          ),
                          onPressed: () {
                            // controller.deleteAddress(address.addressId, context);
                            /*debugPrint("asdasd");*/
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 10, left: 10),
              child: Text(
                line1.join(', '),
                style: TextStyle(fontSize: 16, color: MyColor.greyTextAT),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, left: 10),
              child: Text(
                line2.join(', '),
                style: TextStyle(fontSize: 16, color: MyColor.greyTextAT),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  // width: 60,
                  // color: Colors.blue,
                  child: FlatButton(
                    child: Text(
                      'Perbarui Alamat',
                      style: TextStyle(color: MyColor.redAT),
                    ),
                    onPressed: () {
                      Map<String, dynamic> param = {
                        'controller': controller,
                        'data': address
                      };
                      Get.toNamed(editAddressScreen, arguments: param)
                          .then((value) {
//                        debugPrint("return dari form $value");
                        if (value == null) return;
                        controller.getListAddress();
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => _address(controller.listAddress[index]),
      itemCount: controller.listAddress.length,
    );
  }
}
