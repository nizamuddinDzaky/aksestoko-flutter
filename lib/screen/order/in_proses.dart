import 'package:flutter/material.dart';

class InProsesScreen extends StatefulWidget{
  @override
  _InProsesScreenState createState() => _InProsesScreenState();
}

class _InProsesScreenState extends State<InProsesScreen>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text("In proses")
          ],
        ),
      ),
    );
  }
}