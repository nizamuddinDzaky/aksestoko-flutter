import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/model/promo.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/view_model/promo/promo_view_model.dart';
import 'package:get/get.dart';

class ListPromoScreen extends StatefulWidget {
  @override
  _ListPromoScreenState createState() => _ListPromoScreenState();
}

class _ListPromoScreenState extends PromoViewModel {
  /*@override
  void initState() {
    debugPrint(MyPref.getATToken());
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              "Berita",
              style: TextStyle(fontSize: 20),
            )),
        centerTitle: false,
        actions: <Widget>[],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: actionRefresh,
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        height: listPromo?.isEmpty ?? true
            ? (Get.height -
                56 -
                (MediaQuery.of(context).padding.top + kToolbarHeight))
            : null,
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 20),
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
                    'Daftar Berita',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            listPromo?.isEmpty ?? true
                ? Flexible(
                    child: Center(
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Tidak ada berita tersedia',
                              style: Theme.of(context).textTheme.headline6,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.only(bottom: 100),
                    child: _gridProduct(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _gridProduct() {
    return ListView.builder(
      itemCount: listPromo.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (buildcontext, index) {
        return item_promo(listPromo[index]);
      },
    );
  }

  Widget item_promo(Promo promo) {
    return Card(
      elevation: 2,
      child: InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          /*decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: MyColor.greyTextAT,
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 2), // changes position of shadow
            )
          ],
        ),*/
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
                  promo.name,
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
                      promo.codePromo,
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
                          _showToast(context);
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
            ],
          ),
        ),
        onTap: () {
          Get.toNamed(detailPromo, arguments: promo);
        },
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Copied'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
