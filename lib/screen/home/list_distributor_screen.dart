import 'package:aksestokomobile/controller/home/select_distributor_controller.dart';
import 'package:aksestokomobile/main_common.dart';
import 'package:aksestokomobile/model/distributor.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';

class ListDistributorScreen extends SelectDistributorController {
  listItem(BuildContext context, Distributor distributor, int index) {
    return Card(
      elevation: 2,
      child: InkWell(
        child: Container(
          child: Row(
            children: <Widget>[
              Center(
                child: Container(
                  height: 112,
                  width: 112,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: (distributor?.imageUrl?.isEmpty ?? true) || isDebugOnly
                      ? Image.asset(kDistributor, width: 112)
                      : FadeInImage.assetNetwork(
                          placeholder: kDistributor,
                          image: distributor?.imageUrl ?? '',
                          fit: BoxFit.cover,
                          width: 112,
                        ),
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
                          distributor?.nama ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff999999),
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        child: Text(
                          distributor?.alamatLengkap ?? '',
                          style:
                              TextStyle(color: Color(0xff999999), fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Text(
                          distributor?.noTlpn ?? '',
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
}
