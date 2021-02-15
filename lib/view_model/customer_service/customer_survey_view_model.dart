import 'package:aksestokomobile/model/base_response.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:aksestokomobile/model/order_detail.dart';
import 'package:aksestokomobile/model/question.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/customer_service/customer_survey_screen.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

abstract class CustomerSurveyViewModel extends State<CustomerSurveyScreen> {
  OrderDetail orderDetail;
  List<Question> listQuestion = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();

  bool isRadioSelected = false;

  getListOrder() async {
    listQuestion.clear();
    var status = await ApiClient.methodGet(ApiConfig.urlGetCustomerSurvey,
        params: {}, onBefore: (status) {}, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      listQuestion = baseResponse.data.listQuestion;
      debugLogs([data]);
    }, onFailed: (title, message) {
      debugPrint("failed");
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      debugPrint("error");
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  _submit() {
    formKey.currentState.save();
    var questionBody = [];
    listQuestion.forEach((question) {
      debugPrint('Kode ${question.id} : ${question.answer}');
      if (question.isRequired == '1') {
        if (question.type != 'checkbox') {
          if (question.answer.isEmpty) {
            Fluttertoast.showToast(
              msg: 'Kode ${question.id} Tidak Boleh Kosong',
              gravity: ToastGravity.CENTER,
            );
            return;
          }
        } else {
          if (question.multiAnswer.length == 0 ||
              question.multiAnswer.length > question.maxCheck.toInt()) {
            Fluttertoast.showToast(
              msg: 'Kode ${question.id} Tidak Boleh Kosong',
              gravity: ToastGravity.CENTER,
            );
            return;
          }
        }
      }
      questionBody.add({
        'question_type': question.type,
        'answer': question.type != 'checkbox'
            ? question.answer
            : question.multiAnswer,
        'question': question.id,
      });
    });
    var body = {'jumlah': questionBody.length, 'question': questionBody};

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[CircularProgressIndicator()],
            ),
          );
        });

    _postAddIssue(body);
  }

  _postAddIssue(body) async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlAddCustomerSurvey,
      body,
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, flag) {
        Fluttertoast.showToast(
          msg: data['message'],
          gravity: ToastGravity.CENTER,
        );
        Get.back(result: -1);
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
      onAfter: (status) {},
    );
    setState(() {
      status.execute();
    });
  }

  List<Widget> generateInput() {
    List<Widget> _listInput = [];
    listQuestion.forEach((question) {
      Widget input = Container();
      if (question.type.toString() == "text") input = getTexField(question);
      if (question.type.toString() == "choice")
        input = getRadioButton(question);
      if (question.type.toString() == "rating")
        input = getRatingField(question);
      if (question.type.toString() == "checkbox")
        input = getMultiChoiceField(question);
      _listInput.add(Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: question?.question != null
                            ? '${question?.question}'
                            : '',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                    if ((question?.isRequired == '1' ?? 0))
                      TextSpan(
                          text: ' (wajib isi)',
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                              )),
                  ])),
                  input
                ],
              ))));
    });

    _listInput.add(Container(
      margin: EdgeInsets.only(top: 10),
      child: SizedBox(
        width: double.infinity,
        height: 46,
        child: FlatButton(
            color: MyColor.redAT,
            child: Text(
              'Simpan',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _submit();
            },
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))),
      ),
    ));
    return _listInput;
  }

  Widget getTexField(Question question) {
    return TextFormField(
      onSaved: (value) => question?.answer = value,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: MyDimen.paddingTxtField(),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColor.txtField),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColor.lineTxtField),
        ),
        errorText: '',
        errorStyle: TextStyle(
          color: MyColor.txtField,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget getRadioButton(Question question) {
    if (question?.answer == null && (question?.optionList?.isNotEmpty ?? false))
      question.answer = question.optionList.first.option;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...(question?.optionList ?? []).map((e) {
            return RaisedButton(
              onPressed: () {
                setState(() {
                  question.answer = e.option;
                });
              },
              color:
                  (e.option == question.answer) ? MyColor.redAT : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(
                      color: (e.option == question.answer)
                          ? Colors.white
                          : MyColor.redAT)),
              child: Text(
                e.option,
                style: TextStyle(
                    color: (e.option == question.answer)
                        ? Colors.white
                        : MyColor.redAT),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget getMultiChoiceField(Question question) {
    var maxCheck =
        int.tryParse(question?.maxCheck ?? '') ?? question.multiAnswer.length;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...(question?.optionList ?? []).map((e) {
            bool status = question.multiAnswer.length >= maxCheck &&
                !question.multiAnswer.contains(e.option);
            return RaisedButton(
              onPressed: status
                  ? null
                  : () {
                      setState(() {
                        if (question.multiAnswer.contains(e.option))
                          question.multiAnswer
                              .removeWhere((ans) => ans == e.option);
                        else {
                          if (question.multiAnswer.length < maxCheck) {
                            question.multiAnswer.add(e.option);
                          } else {
                            Get.defaultDialog(
                                title: "",
                                content: Text("Maksimal ${question.maxCheck}"));
                          }
                        }
                      });
                    },
              color: (question.multiAnswer.contains(e.option))
                  ? MyColor.redAT
                  : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side:
                      BorderSide(color: status ? Colors.white : MyColor.redAT)),
              child: Text(
                e.option,
                style: TextStyle(
                    color: status || question.multiAnswer.contains(e.option)
                        ? Colors.white
                        : MyColor.redAT),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget getRatingField(Question question) {
    if (question?.answer == null) question.answer = 3.toString();

    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        question.answer = rating.toString();
      },
    );
  }

  Future<void> actionRefresh() async {
    await getListOrder();
  }
}
