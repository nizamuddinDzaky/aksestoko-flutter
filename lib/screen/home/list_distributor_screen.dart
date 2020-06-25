import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';

class ListDistributorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        child: Container(
          child: Row(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Image.asset(kDistributor),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Distributor Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff999999),
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Text(
                          'SBJ',
                          style:
                              TextStyle(color: Color(0xff999999), fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        child: Text(
                          'Jl. Lorem Ipsum No 40 Gresik Jawa Timur',
                          style:
                              TextStyle(color: Color(0xff999999), fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Text(
                          '081335789789',
                          style:
                              TextStyle(color: Color(0xff999999), fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: null,
      ),
    );
  }
}
