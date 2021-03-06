import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/main_common.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:aksestokomobile/view_model/account/reward_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RewardScreen extends StatefulWidget {
  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends RewardViewModel {
  Widget pointLayout() {
    return Column(
      children: [
        SizedBox(height: 20),
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Get.toNamed(rewardScreen);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              // height: 104,
              child: Column(
                children: [
                  Row(
                    children: [
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            'assets/icons/reward_gold.png',
                            width: 32,
                            height: 32,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Poin Saya',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      point == null
                          // ? CircularProgressIndicator()
                          ? Container()
                          : Text(
                              '${point ?? '-'}',
                              style: TextStyle(
                                color: MyColor.redAT,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ],
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                    color: MyColor.redAT,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 64),
                      child: Text(
                        'Lihat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed(summaryScreen);
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: MyColor.redAT,
            height: 300,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Image.asset(
              bgHeaderTop,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text('Reward'),
              ),
              Expanded(
                child: RefreshIndicator(
                    key: refreshKey,
                    onRefresh: actionRefresh,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(60)),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 1),
                                  color: Colors.black.withOpacity(0.20),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              child: Image.asset(kDistributor),
                            ),
                          ),
                          Center(
                            child: Container(
                              child: Text(
                                profile?.namaToko ?? "Akses Toko",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              child: Text(
                                profile?.kodeBk ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: pointLayout(),
                          ),
                          // if (isDebugOnly && point == null)
                          if (false)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                      // height: 104,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Card(
                                                elevation: 8,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(32),
                                                ),
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Image.asset(
                                                    'assets/icons/reward_gold.png',
                                                    width: 32,
                                                    height: 32,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Kontrak',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 4),
                                                    LinearPercentIndicator(
                                                      lineHeight: 15,
                                                      percent: 0.5,
                                                      backgroundColor:
                                                          Colors.grey[300],
                                                      progressColor:
                                                          MyColor.mainGreen,
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text(
                                                      '1000 / 2000 Ton',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            MyColor.greyTextAT,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12),
                                          RaisedButton(
                                            color: MyColor.redAT,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 64),
                                              child: Text(
                                                'Lihat',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Get.toNamed(summaryScreen);
                                            },
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20.0)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Khusus untuk Anda",
                              style: TextStyle(
                                fontSize: 20,
                                color: MyColor.greyTextAT,
                              ),
                            ),
                          ),
                          if ((listReward?.length ?? 0) == 0)
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 16),
                                  Icon(
                                    Icons.info_outline,
                                    color: MyColor.blueDio,
                                    size: 64,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Belum ada penawaran',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )
                                ],
                              ),
                            ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (bc, idx) {
                                    var reward = listReward[idx];
                                    return Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                          color: MyColor.greyAT,
                                          width: 1,
                                        ),
                                      ),
                                      child: Container(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                    topRight:
                                                        Radius.circular(12),
                                                  ),
                                                  child: AspectRatio(
                                                    aspectRatio: 2 / 1,
                                                    child: Container(
                                                      child: (reward.image
                                                                      .isEmpty ??
                                                                  true) ||
                                                              isDebugOnly
                                                          ? Image.asset(
                                                              kNoImageLandscape,
                                                              fit: BoxFit.cover)
                                                          : FadeInImage
                                                              .assetNetwork(
                                                              placeholder:
                                                                  kNoImageLandscape,
                                                              image: reward
                                                                      .image ??
                                                                  '',
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            ),
                                                    ),
                                                  ) /*:Image.asset(
                                              bgReward,
                                              fit: BoxFit.cover,
                                            ),*/
                                                  /*,*/
                                                  ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 12,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${reward?.title}',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: MyColor
                                                                .greyTextAT,
                                                          ),
                                                        ),
                                                        SizedBox(height: 4),
                                                        Text(
                                                          '${reward?.description.htmlToStr()}',
                                                          maxLines: 4,
                                                          style: TextStyle(
                                                            color: MyColor
                                                                .greyTextAT,
                                                          ),
                                                        ),
                                                        SizedBox(height: 4),
                                                        Text(
                                                          '${strToDate(reward.validUntil)}',
                                                          style: TextStyle(
                                                            color: MyColor
                                                                .greyTextAT,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  CupertinoButton(
                                                    minSize: 0,
                                                    padding: EdgeInsets.zero,
                                                    child: Text(
                                                      'Detail',
                                                    ),
                                                    onPressed: () {
                                                      Get.toNamed(
                                                        detailRewardScreen,
                                                        arguments: reward,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (bc, idx) {
                                    return SizedBox(height: 12);
                                  },
                                  itemCount: listReward?.length,
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
