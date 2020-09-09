import 'package:aksestokomobile/model/Address.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/view_model/home/list_address_view_model.dart';
import 'package:flutter/material.dart';

class ListAddressScreen extends StatefulWidget {
  @override
  _ListAddressScreenState createState() => _ListAddressScreenState();
}

class _ListAddressScreenState extends ListAddressViewModel {

  Widget _address(Address address){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(
        top: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
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
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: 15, right: 15, bottom: 15),

            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.location_on,
                          color: MyColor.redAT,
                        ),
                      ),
                      Text(
                        address != null ? "${address.namaPenerima}" : "",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          address != null ? "${address.namaPenerima}, " : "",
                          style: TextStyle(
                              fontSize: 16, color: MyColor.greyTextAT),
                        ),
                      ),
                      Container(
                        child: Text(
                          address != null ? "${address.noTlpn}" : "",
                          style: TextStyle(
                              fontSize: 15, color: MyColor.greyTextAT),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          address != null ? "${address.alamat}, ${address.kecamatanName}, ${address.kabupatenName}, ${address.provinceName}" : "",
                          style: TextStyle(
                              fontSize: 16, color: MyColor.greyTextAT),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 3,
            color: Color(0xffEAEAEA),
            margin: EdgeInsets.symmetric(vertical: 0),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 20, right: 20, top: 15, bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "SUBTOTAL",
                  style: TextStyle(
                      color: Color(0xff999999),
                      fontWeight: FontWeight.bold),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index)=> _address(listAddress[index]),
      itemCount: listAddress.length,
    );
  }
}
