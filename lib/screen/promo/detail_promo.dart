import 'package:aksestokomobile/model/promo.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:get/get.dart';

class DetailPromoScreen extends StatefulWidget {
  final Promo promo;

  DetailPromoScreen({this.promo});

  @override
  _DetailPromoScreenState createState() => _DetailPromoScreenState();
}

class _DetailPromoScreenState extends State<DetailPromoScreen> with SingleTickerProviderStateMixin {

  Promo promo;

  @override
  void initState() {
    promo = Get.arguments as Promo ?? widget.promo;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var title = promo?.typeNews == 'promo' ? 'Promo' : 'Berita';
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
              'Detail $title',
              style: TextStyle(fontSize: 20),
            )),
        centerTitle: false,
        actions: <Widget>[],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: _body(),
      ),
    );
  }

  Widget _body(){
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
                  promo?.name ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.only(bottom: 100),
            child: _content(),
          ),
        ],
      ),
    );
  }

  Widget _content(){
    return Card(
      elevation: 2,
      child : InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: <Widget>[
              Container(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: (promo.urlImage?.isEmpty ?? true) || kDebugMode
                      ? Image.asset(kNoImage)
                      : FadeInImage.assetNetwork(
                    placeholder: kNoImage,
                    image: promo.urlImage ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  promo?.name ?? '',
                  style: TextStyle(
                    color: MyColor.blackTextAT,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                /*margin: EdgeInsets.symmetric(vertical: 5),*/
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      promo?.codePromo ?? '',
                      style: TextStyle(
                          color: MyColor.greyTextAT,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'SALIN KODE',
                          style: TextStyle(
                            color: MyColor.redAT,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () {
                          FlutterClipboard.copy(promo.codePromo);
                        },
                      ),
                    ),
                    /*Text(
                      "Salin Kode",

                      style: TextStyle(
                          color: MyColor.redAT),
                    ),*/
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 1,
                      width: 100,
                      color: MyColor.redAT,
                      margin: EdgeInsets.only(top: 0, bottom: 0, left: 5)
                    )
                  ],
                ),
              ),
              Container(
                child: Wrap(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 5, bottom: 0, left: 10),
                        child: Text(
                          promo?.description ?? '',
                          style: TextStyle(color: MyColor.greyTextAT),
                        ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                        height: 1,
                        width: 100,
                        color: MyColor.redAT,
                        margin: EdgeInsets.only(top: 5, bottom: 0, left: 5)
                    )
                  ],
                ),
              ),
              Container(
                child: Wrap(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 0, left: 10),
                      child: Text(
                        "Min Pembelian ${MyNumber.toNumberRpStr(promo.minPembelian)} | Max Potongan ${MyNumber.toNumberRpStr(promo.maxTotalDisc)} | Berlaku sampai ${strToDate(promo.endDate)}",
                        style: TextStyle(color: MyColor.greyTextAT),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          debugPrint("asd");
          // await gotoParent(context, distributor);
        },
      ),

    );
  }
}