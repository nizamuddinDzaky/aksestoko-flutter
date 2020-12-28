import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/promo.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class DetailPromoScreen extends StatefulWidget {
  final Promo promo;

  DetailPromoScreen({this.promo});

  @override
  _DetailPromoScreenState createState() => _DetailPromoScreenState();
}

class _DetailPromoScreenState extends State<DetailPromoScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  Promo promo;
  String idPromo;
  String errorMessage;

  void _getDetail() async {
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailPromo,
      params: {
        'promo_id': idPromo,
      },
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        var response = BaseResponse.fromJson(data);
        promo = response?.data?.promo;
      },
      onFailed: (title, message) {
        promo = null;
        var response = BaseResponse.fromString(message);
        errorMessage = response?.message ?? 'Gagal';
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message));
      },
      onAfter: (status) {},
    );
    setState(() {
      status.execute();
    });
  }

  Future<void> actionRefresh() async {
    if (promo?.id != null) idPromo = promo.id;
    if (idPromo != null) _getDetail();
  }

  void _actionRefresh() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshKey?.currentState?.show();
    });
  }

  @override
  void initState() {
    promo = Get.arguments as Promo ?? widget.promo;
    if (promo?.getDetail == true) _actionRefresh();
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
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: actionRefresh,
          child: promo == null ? _message() : _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
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

  Widget _message() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          '${errorMessage ?? ''}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _content() {
    return Card(
      elevation: 2,
      child: InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 2 / 1,
                child: Container(
                  child: (promo?.urlImage?.isEmpty ?? true) || kDebugMode
                      ? Image.asset(kNoImageLandscape)
                      : FadeInImage.assetNetwork(
                          placeholder: kNoImageLandscape,
                          image: promo.urlImage ?? '',
                          fit: BoxFit.fitWidth,
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
                        margin: EdgeInsets.only(top: 0, bottom: 0, left: 5))
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
                        margin: EdgeInsets.only(top: 5, bottom: 0, left: 5))
                  ],
                ),
              ),
              Container(
                child: Wrap(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 0, left: 10),
                      child: Text(
                        "Min Pembelian ${MyNumber.toNumberRpStr(
                            promo?.minPembelian ??
                                '')} | Max Potongan ${MyNumber.toNumberRpStr(
                            promo?.maxTotalDisc ?? '')} | Berlaku sampai ${promo
                            ?.endDate == null ? '' : strToDate(promo.endDate)}",
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
