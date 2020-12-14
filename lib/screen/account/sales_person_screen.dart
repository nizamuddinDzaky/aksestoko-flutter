import 'package:aksestokomobile/view_model/account/sales_person_view_model.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/resource/my_image.dart';

class SalesPersonScreen extends StatefulWidget {
  _SalesPersonScreenState createState() => _SalesPersonScreenState();
}

class _SalesPersonScreenState extends SalesPersonViewModel {
  Widget _layoutReferralCode() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 50),
      child: Column(
        children: [
          Text(
            'Data Salesperson yang mendaftarkan toko.',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: referralCodeTextController,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            onFieldSubmitted: (text) {
              putReferralCode(text);
            },
            decoration: InputDecoration(
              labelText: 'Kode Referal',
            ),
          ),
          SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: FlatButton(
                color: MyColor.redAT,
                child: Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  putReferralCode(referralCodeTextController.text);
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> address = [
      salesPerson?.alamat,
      salesPerson?.kecamatan,
      salesPerson?.kabupaten,
      salesPerson?.provincy,
    ].where((element) => element != null).toList();
    var formLayout = Container(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "Sales Person",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 1),
                    color: Colors.black.withOpacity(0.40),
                  ),
                ],
              ),
              child: RefreshIndicator(
                key: refreshKey,
                onRefresh: actionRefresh,
                child: salesPerson == null
                    ? _layoutReferralCode()
                    : SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(),
                            Text(
                              salesPerson?.name ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26),
                            ),
                            Text(
                              salesPerson?.company ?? '',
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 25)),
                            Text(
                              "Reference No",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: MyColor.greyTextAT),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                            Text(
                              salesPerson?.refenceNo ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 20)),
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: MyColor.greyTextAT),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                            Text(
                              salesPerson?.email ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 20)),
                            Text(
                              "No Hp",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: MyColor.greyTextAT),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                            Text(
                              salesPerson?.noTlp ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 20)),
                            Text(
                              "Alamat",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: MyColor.greyTextAT),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                            Text(
                              address.join(', '),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        Image.asset(
          bgLarge,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: formLayout,
          ),
        )
      ],
    );
  }
}
