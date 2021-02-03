import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/model/Issue.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/screen/customer_service/add_issue_screen.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/view_model/customer_service/customer_service_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerServiceScreen extends StatefulWidget {
  @override
  _CustomerServiceScreenState createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends CustomerServiceViewModel {

  Widget _body(){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: MyColor.greyTextAT,
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: Offset(0, 2),
                )
              ],
            ),
            height: 50,
            child: Row(
              children: [
                RaisedButton(
                  color: MyColor.redAT,
                  child: Text(
                    'Tambah Keluhan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    _dialogAddIssue(context);
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8),
                SizedBox(height: 8),
                Text(
                  'Hanya menampilkan 5 keluhan terbaru',
                  style: TextStyle(
                    color: MyColor.blackTextAT,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          (listIssue?.isEmpty ?? true)
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
                        'Tidak ada Issue tersedia',
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ],
                  ),
                ),
                ListView(),
              ],
            ),
          ) :
          Expanded(
              /*child:_listIssue()*/
            child: Stack(
              children: [
                _listIssue()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listIssue() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      itemCount: listIssue?.length ?? 0,
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemBuilder: (buildcontext, index) {
        return _itemIssue(listIssue[index]);
      },
    );
  }

  Widget _itemIssue(Issue issue){
    return Card(
      elevation: 2,
      child: InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: <Widget>[
              Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "${issue.subject}",
                        style: TextStyle(
                          color: MyColor.blackTextAT,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]
              ),
              Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "${issue.description}",
                        style: TextStyle(
                          color: MyColor.blackTextAT,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]
              ),
              Container(
                height: 3,
                color: Color(0xffEAEAEA),
                margin: EdgeInsets.symmetric(vertical: 10),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  /*mainAxisAlignment: MainAxisAlignment.spaceBetween,*/
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Tipe Tiket",
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "${issue.type}",
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Kode Tiket",
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "${issue.key}",
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Tipe Tiket",
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "${issue.type}",
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Kode Tiket",
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "${issue.key}",
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
              ),
            ],
          ),
        ),
        onTap: () {
          Get.toNamed(detailIssueScreen, arguments: issue);
          /*Get.toNamed(detailPromo, arguments: promo);*/
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /*super.build(context);*/
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
            "Layanan Pelanggan",
            style: TextStyle(fontSize: 20),
          )
        ),
        centerTitle: true,
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

  _dialogAddIssue(BuildContext context) {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Tambah Keluhan'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                    width: double.maxFinite,
                    child: AddIssueScreen((param){
                      if(param){
                        actionRefresh();
                      }
                    })
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}