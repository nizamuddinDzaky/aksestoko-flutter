import 'package:aksestokomobile/model/reward.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:get/get.dart';

import '../../main_common.dart';

class DetailRewardScreen extends StatefulWidget {
  @override
  _DetailRewardScreenState createState() => _DetailRewardScreenState();
}
class _DetailRewardScreenState extends State<DetailRewardScreen>
  with SingleTickerProviderStateMixin {
  Reward _reward;
  Widget _content() {
    return Card(
      elevation: 2,
      child: InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 2 / 1,
                child: Container(
                  child: /*(_reward?.image?.isEmpty ?? true) || isDebugOnly
                      ? Image.asset(kNoImageLandscape)
                      :*/ FadeInImage.assetNetwork(
                    placeholder: kNoImageLandscape,
                    image: _reward?.image ?? '',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              /*if (promo?.typeNews?.toLowerCase() != 'info')*/
                Container(
                  margin:
                  EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                  /*margin: EdgeInsets.symmetric(vertical: 5),*/
                  child: Wrap(
                    children: <Widget>[
                      Container(
                        // margin: EdgeInsets.only(top: 5, bottom: 0, left: 10),
                        child: Text(
                          "${_reward.description.htmlToStr()}",
                          style: TextStyle(
                              color: MyColor.greyTextAT,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              Container(
                  height: 1,
                  width: double.infinity,
                  color: MyColor.blackTextAT,
                  margin: EdgeInsets.only(top: 10, bottom: 0, left: 5, right: 5)
              ),
              Container(
                child: Wrap(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 0, left: 10),
                      child: Text(
                        "Valid Sampai : ${strToDate(_reward.validUntil)}",
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
          debugLog("asd");
          // await gotoParent(context, distributor);
        },
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
                  "${_reward.title}",
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


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var title = 'Reward';
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
        child: _body()
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reward = Get.arguments as Reward ;
  }
}