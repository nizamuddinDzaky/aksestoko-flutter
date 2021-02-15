import 'package:aksestokomobile/main_common.dart';
import 'package:aksestokomobile/model/credit_program.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/screen/setting/webview_screen.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:aksestokomobile/view_model/credit_program/credit_program_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditProgramScreen extends StatefulWidget {
  @override
  _CreditProgramScreenState createState() => _CreditProgramScreenState();
}

class _CreditProgramScreenState extends CreditProgramViewModel {

  Widget _body() {
    return Container(
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
                  'Program Kredit',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          (listCreditProgram?.isEmpty ?? true)
              ? Expanded(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.new_releases_sharp,
                        color: MyColor.redAT,
                        size: 64,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tidak ada Program Kredit',
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ],
                  ),
                ),
                ListView(),
              ],
            ),
          )
              : Expanded(
            child: _listCreditProgram(),
          ),
        ],
      ),
    );
  }

  Widget _listCreditProgram() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      itemCount: listCreditProgram?.length ?? 0,
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemBuilder: (buildcontext, index) {
        return _itemPromo(listCreditProgram[index]);
      },
    );
  }

  Widget _itemPromo(CreditProgram creditProgram) {
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
                  child: (creditProgram?.image?.isEmpty ?? true)
                      ? Image.asset(kNoImageLandscape)
                      : FadeInImage.assetNetwork(
                    placeholder: kNoImageLandscape,
                    image: creditProgram?.image ?? '',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  creditProgram?.title ?? '',
                  style: TextStyle(
                    color: MyColor.blackTextAT,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              Container(
                margin:
                EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                child: Text(
                  creditProgram?.description ?? '',
                  style: TextStyle(
                      color: MyColor.blackTextAT,
                      fontWeight: FontWeight.normal,
                      fontSize: 13,),
                ),
              ),
              Container(
                height: 3,

                color: Color(0xffEAEAEA),
                margin: EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
              ),
              Container(
                margin: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                      child: Expanded(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Oleh :",
                              style: TextStyle(color: MyColor.greyTextAT),

                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                            ),
                            Container(
                              child: Text(
                                creditProgram.providedBy,
                                style: TextStyle(
                                    color: MyColor.greyTextAT,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'ISI FORM',
                          style: TextStyle(
                            color: MyColor.redAT,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () {
                          var url = "${ApiConfig.urlWebViewCreditProgram}?token=${MyPref.getATToken()}&redirect=${creditProgram.redirectForm}";
                          Map<String, dynamic> _param = {
                            "url": url,
                            "title": "${creditProgram.title}"
                          };
                          Get.to(
                            WebViewScreen(url),
                            arguments: _param,
                          );
                          /*Get.toNamed(
                              detailOrderScreen, arguments: _order?.idPemesanan);*/
                        },
                      ),
                    ),

                    Container(
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'LIHAT DETAIL',
                          style: TextStyle(
                            color: MyColor.redAT,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () {
                          var url = "${ApiConfig.urlWebViewCreditProgram}?token=${MyPref.getATToken()}&redirect=${creditProgram.redirectView}";
                          Map<String, dynamic> _param = {
                            "url": url,
                            "title": "${creditProgram.title}"
                          };
                            Get.to(
                              WebViewScreen(url),
                              arguments: _param,
                            );
                          /*Get.toNamed(
                              detailOrderScreen, arguments: _order?.idPemesanan);*/
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          /*Get.toNamed(detailPromo, arguments: promo);*/
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              "Program Kredit",
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
}