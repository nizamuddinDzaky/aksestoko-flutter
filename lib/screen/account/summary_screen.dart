import 'package:aksestokomobile/model/summary.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/view_model/account/summary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends SummaryViewModel {
  Widget _summaryItem(Summary summary) {
    var total = [
      summary?.kuantitas,
      summary?.satuan,
    ];
    total.removeWhere((element) => element == null);
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          summary?.tanggal ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: MyColor.greyTextAT,
                          ),
                        ),
                        Text(
                          summary?.nomorTransaksi ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: MyColor.redAT,
                          ),
                        ),
                        Text(
                          summary?.namaDistributor ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          summary?.namaProduk ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*Text(
                    '${(0 + 1) * 15} Ton',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: MyColor.greenAT,
                    ),
                  ),*/
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(height: 0),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Text(
                    'TOTAL',
                  ),
                  Expanded(
                    child: Text(
                      total.join(' '),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Ringkasan Pemesanan',
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 54),
              Expanded(
                child: RefreshIndicator(
                  key: refreshKey,
                  onRefresh: actionRefresh,
                  child: (listSummary?.length ?? 0) == 0
                      ? Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: MyColor.redAT,
                                    size: 64,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Tidak ada data transaksi',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )
                                ],
                              ),
                            ),
                            ListView(),
                          ],
                        )
                      : ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(16),
                          itemBuilder: (bc, idx) {
                            final size = (listSummary?.length ?? 0);
                            if (idx == size) {
                              return Center(child: Text('$size data'));
                            }
                            final summary = listSummary[idx];
                            return _summaryItem(summary);
                          },
                          separatorBuilder: (bc, idx) {
                            return SizedBox(height: 12);
                          },
                          itemCount: (listSummary?.length ?? 0) + 1,
                        ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: MyColor.greyTextAT,
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: Offset(0, 2),
                )
              ],
            ),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Pilih Periode ',
                    ),
                    OutlineButton(
                      child: Text(DateFormat('MMMM yyyy').format(currentDate)),
                      borderSide: BorderSide(color: MyColor.blueDio),
                      onPressed: pickMonth,
                    ),
                  ],
                ),
/*
                RaisedButton(
                  color: MyColor.redAT,
                  child: Text(
                    'Terapkan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                ),
*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
