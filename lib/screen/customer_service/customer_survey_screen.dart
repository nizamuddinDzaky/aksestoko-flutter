import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:aksestokomobile/view_model/customer_service/customer_survey_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerSurveyScreen extends StatefulWidget {
  @override
  _CustomerSurveyScreenState createState() => _CustomerSurveyScreenState();
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint("onTap $value $groupValue");
        if (value != groupValue) onChanged(value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              groupValue: groupValue,
              value: value,
              onChanged: (bool newValue) {
                debugPrint("asdsadsa");
                onChanged(newValue);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}


class _CustomerSurveyScreenState extends CustomerSurveyViewModel {
  @override
  void initState() {
    actionRefresh();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var formLayout = Container(
      child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Survei Pelanggan",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 1),
                      color: Colors.black.withOpacity(0.40),
                    ),
                  ],
                ),
                child: listQuestion.length == 0 ? Center(
                  child: CircularProgressIndicator(),
                ) :
                RefreshIndicator(
                  key: refreshKey,
                  onRefresh: actionRefresh,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Form(
                          key: formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: generateInput()/*<Widget>[*/

                              /*Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                  height: 104,
                                  child: TextFormField(
                                    // controller: firstNameTextController,
                                    // onSaved: (value) => profile?.namaDepan = value,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      contentPadding: MyDimen.paddingTxtField(),
                                      labelText: 'Type Text',
                                      labelStyle: TextStyle(
                                        color: MyColor.txtField,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: MyColor.txtField),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: MyColor.lineTxtField),
                                      ),
                                      errorText: '',
                                      errorStyle: TextStyle(
                                        color: MyColor.txtField,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                )
                              ),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {

                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Type Choice",
                                          style: TextStyle(
                                              color: MyColor.blackTextAT,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(height: 5),
                                        LabeledRadio(
                                          label: 'This is the first label text',
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          value: true,
                                          groupValue: _isRadioSelected,
                                          onChanged: (bool newValue) {
                                            setState(() {
                                              _isRadioSelected = newValue;
                                            });
                                          },
                                        ),
                                        LabeledRadio(
                                          label: 'This is the second label text',
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
                                          value: false,
                                          groupValue: _isRadioSelected,
                                          onChanged: (bool newValue) {
                                            setState(() {
                                              _isRadioSelected = newValue;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Type Checkbox",
                                          style: TextStyle(
                                              color: MyColor.blackTextAT,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Container(
                                          child: CheckboxListTile(
                                            title: Text("title text"),
                                            checkColor: Colors.greenAccent,
                                            activeColor: Colors.red,
                                            value: this.valuefirst,
                                            controlAffinity: ListTileControlAffinity.leading,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.valuefirst = value;
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          child: CheckboxListTile(
                                            dense: true,
                                            title: Text("title text"),
                                            checkColor: Colors.greenAccent,
                                            activeColor: Colors.red,
                                            value: this.valuefirst,
                                            controlAffinity: ListTileControlAffinity.leading,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.valuefirst = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )*/
                            /*]*/
                          )
                        )
                      ],
                    )
                  ),
                )
              ),
            )
          ]
      ),
    );


    return Stack(
      children: <Widget>[
        Image.asset(
          bgLarge,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: formLayout,
          ),
        )
      ],
    );
      /*ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => _delivery(listDetailDelivery[index]),
      itemCount: listQuestion.length,
    );*/
  }
  
}