import 'package:aksestokomobile/model/issue.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/view_model/customer_service/detail_issue_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailIssueScreen extends StatefulWidget {
  @override
  _DetailIssueScreenState createState() => _DetailIssueScreenState();
}

class _DetailIssueScreenState extends DetailIssueViewModel {
  Widget _body() {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 5, left: 25, right: 25),
                child: Text(
                  issue?.subject ?? '',
                  style: TextStyle(
                      color: MyColor.blackTextAT,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 25, left: 25, right: 25),
                child: Text(
                  issue?.description ?? '',
                  style: TextStyle(
                      color: MyColor.blackTextAT,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
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
                ),
                child: Column(children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Tipe Tiket",
                                  style: TextStyle(
                                    color: MyColor.blackTextAT,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  issue?.type ?? '',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Kode Tiket",
                                  style: TextStyle(
                                    color: MyColor.blackTextAT,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  issue?.key ?? '',
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
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Status Tiket",
                                  style: TextStyle(
                                    color: MyColor.blackTextAT,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  issue?.status ?? '',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Di Tangani Oleh",
                                  style: TextStyle(
                                    color: MyColor.blackTextAT,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  issue?.assignee ?? '',
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
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Dibuat Pada",
                                  style: TextStyle(
                                    color: MyColor.blackTextAT,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  issue?.created ?? '\n',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Diperbarui Pada",
                                  style: TextStyle(
                                    color: MyColor.blackTextAT,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  issue?.updated ?? '\n',
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
                ]),
              ),
              Container(
                margin:
                    EdgeInsets.only(bottom: 10, left: 25, right: 25, top: 25),
                child: Text(
                  "Komentar",
                  style: TextStyle(
                      color: MyColor.blackTextAT,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              if (issue?.comments != null)
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: issue?.comments?.length ?? 0,
                    itemBuilder: (buildContext, index) {
                      return _listComment(issue.comments[index]);
                    },
                  ),
                ),
              Container(
                margin:
                    EdgeInsets.only(bottom: 10, left: 25, right: 25, top: 20),
                child: TextFormField(
                  controller: commentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  // maxLength: 1000,
                  onSaved: (value) => {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffEEEEEE),
                    hintText: "Tuliskan Komentar Anda",
                    contentPadding: const EdgeInsets.only(left: 20, top: 30),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffC8C8C8), width: 2.0),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColor.redAT, width: 1),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                  left: 25,
                  right: 25,
                ),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: MyColor.redAT,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: FlatButton(
                  child: Text(
                    "Kirim",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  onPressed: () => actionSubmitComment(),
                ),
              ),
            ],
          )),
    );
  }

  Widget _listComment(Comments comments) {
    var backgroud = comments.isUser ? MyColor.redAT : Colors.white;
    var colorText = comments.isUser ? Colors.white : Colors.black;
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(left: 25, right: 25, top: 5),
      decoration: BoxDecoration(
        color: backgroud,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: MyColor.greyTextAT,
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5, right: 25),
            child: Text(
              "${comments?.body}",
              style: TextStyle(
                  color: colorText, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5, right: 25),
            child: Text(
              "Oleh ${comments?.author} pada ${comments.created}",
              style: TextStyle(
                  color: colorText, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
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
              "Tiket ${issue?.key ?? ''}",
              style: TextStyle(fontSize: 20),
            )),
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
}
