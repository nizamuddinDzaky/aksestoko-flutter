import 'package:flutter/material.dart';

class OrderDoneScreen extends StatefulWidget{
  @override
  _OrderDoneScreenState createState() => _OrderDoneScreenState();
}

class _OrderDoneScreenState extends State<OrderDoneScreen>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text("Done")
          ],
        ),
      ),
    );
  }
}