import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/view_model/customer_service/add_issue_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddIssueScreen extends StatefulWidget {
  final Function(bool) onSelectDelivery;

  AddIssueScreen(this.onSelectDelivery);

  @override
  _AddIssueScreen createState() => _AddIssueScreen();
}

class _AddIssueScreen extends AddIssueViewModel {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      "Subject",
                      style: TextStyle(
                          color: MyColor.blackTextAT,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    child: DropdownButton(
                      hint: Text("Pilih Subject"),
                      isExpanded: true,
                      items: subjectList.map(
                        (val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      value: subjectValue,
                      onChanged: (value) {
                        setState(() {
                          subjectValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: Text(
                      "Keluhan Anda",
                      style: TextStyle(
                          color: MyColor.blackTextAT,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: issueController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                maxLength: 1000,
                onSaved: (value) => {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffEEEEEE),
                  hintText: "Keluhan Anda",
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
              Container(
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
                  onPressed: () => actionSubmitIssue(),
                ),
              ),
            ],
          )),
    );
  }
}
