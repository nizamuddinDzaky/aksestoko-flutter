import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';

class ListProductScreen extends StatefulWidget {
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
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
                Container(
                  child: FlatButton(
                    color: Color(0xFF387C2B),
                    onPressed: () {},
                    shape: CircleBorder(),
                    child: Text(
                      '-',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      child: Text(
                        "5",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    color: Color(0xFF387C2B),
                    onPressed: () {},
                    shape: CircleBorder(),
//                      padding: EdgeInsets.all(5),
                    child: Text(
                      '+',
                      style: TextStyle(color: Colors.white, fontSize: 24),
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
