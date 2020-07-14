import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/services.dart';

class ListProductScreen extends StatefulWidget {
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = "0"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        //color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                //color: Colors.blue,
                child: Image.asset(
                  kImageDynamix,
                  height: 140,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'Semen Lorem Ipsum Dolor Ismet PCC 50 KG',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Rp 5800',
                      style: TextStyle(
                        color: Color(0xffB20838),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' / SAK',
                      style: TextStyle(
                        color: Color(0xff999999),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 10),
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: FlatButton(
                      color: Color(0xFF387C2B),
                      onPressed: () {
                        int currentValue = int.parse(_controller.text);
                        setState(() {
                          print("tes minus");
                          currentValue--;
                          _controller.text =
                              (currentValue > 0 ? currentValue : 0).toString();
                        });
                      },
                      shape: CircleBorder(),
                      child: Text(
                        '-',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 50,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                      ),
                      controller: _controller,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: false,
                        signed: true,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: FlatButton(
                      color: Color(0xFF387C2B),
                      onPressed: () {
                        int currentValue = int.parse(_controller.text);
                        setState(() {
                          currentValue++;
                          _controller.text = (currentValue).toString();
                        });
                      },
                      shape: CircleBorder(),
//                      padding: EdgeInsets.all(5),
                      child: Text(
                        '+',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
