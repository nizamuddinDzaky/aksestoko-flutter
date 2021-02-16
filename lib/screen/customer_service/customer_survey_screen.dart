import 'package:aksestokomobile/main_common.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/view_model/customer_service/customer_survey_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerSurveyScreen extends StatefulWidget {
  @override
  _CustomerSurveyScreenState createState() => _CustomerSurveyScreenState();
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
      child: Column(children: <Widget>[
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
              padding: EdgeInsets.only(top: 5),
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
              child: listQuestion.length == 0
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : RefreshIndicator(
                key: refreshKey,
                onRefresh: actionRefresh,
                child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        horizontal: 30, vertical: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Form(
                            key: formKey,
                            child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: generateInput()))
                      ],
                    )),
              )),
        )
      ]),
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
            actions: [
              if (isDebugOnly)
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    actionSubmit();
                  },
                ),
            ],
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
  }
}
