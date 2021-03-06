import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/model/issue.dart';
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
  Widget _body() {
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
            child: Center(
              child: Text(
                "Hanya menampilkan 5 keluhan terbaru",
                style: TextStyle(
                  color: MyColor.blackTextAT,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Center(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       SizedBox(height: 8),
          //       SizedBox(height: 8),
          //       Text(
          //         'Hanya menampilkan 5 keluhan terbaruaa',
          //         style: TextStyle(
          //           color: MyColor.blackTextAT,
          //           fontWeight: FontWeight.normal,
          //           fontSize: 16,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
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
                )
              : Expanded(
                  child: Stack(
                    children: [_listIssue()],
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
      itemBuilder: (buildContext, index) {
        return _itemIssue(listIssue[index]);
      },
    );
  }

  Widget _itemIssue(Issue issue) {
    return Card(
      elevation: 2,
      child: InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "${issue.subject ?? ''}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MyColor.blackTextAT,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "${issue.description ?? ''}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MyColor.blackTextAT,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                height: 3,
                color: Color(0xffEAEAEA),
                margin: EdgeInsets.symmetric(vertical: 10),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Tipe Tiket",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "${issue.type ?? ''}",
                              textAlign: TextAlign.center,
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
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Kode Tiket",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "${issue.key ?? ''}",
                              textAlign: TextAlign.center,
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
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Status Tiket",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "${issue.status ?? ''}",
                              textAlign: TextAlign.center,
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
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Ditangani oleh",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "${issue.assignee ?? ''}",
                              textAlign: TextAlign.center,
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
                  ]),
            ],
          ),
        ),
        onTap: () {
          Get.toNamed(detailIssueScreen, arguments: issue);
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
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(
              "Layanan Pelanggan",
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
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 9), // changes position of shadow
                  )
                ],
              ),
              child: RaisedButton(
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
            ),
          ),
        ],
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
                    child: AddIssueScreen((param) {
                      if (param) {
                        actionRefresh();
                      }
                    })),
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
        ));
  }
}
