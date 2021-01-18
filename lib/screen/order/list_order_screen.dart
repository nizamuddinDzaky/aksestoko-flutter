import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/view_model/order/list_order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:aksestokomobile/screen/order/list_history_order_screen.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ListOrderScreen extends StatefulWidget {
  final String status;

  ListOrderScreen(this.status);

  @override
  _ListOrderScreenState createState() => _ListOrderScreenState();
}

class _ListOrderScreenState extends ListOrderViewModel {
  Widget _buildProgressIndicator() {
    if (lastOffset == null) return Container();
    if ((listOrder?.length ?? 0) < 2 && isLoading == 1) return Container();
    return Container(
      height: 52,
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: endScroll == 1
            ? CircularProgressIndicator()
            : Text('${listOrder?.length ?? 0} data'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 70),
            Expanded(
              child: RefreshIndicator(
                key: refreshKey,
                onRefresh: actionRefresh,
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: (listOrder?.length ?? 0) + 1,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (buildcontext, index) {
                    if (index == listOrder?.length) {
                      return _buildProgressIndicator();
                    }
                    return ListHistoryOrderProductScreen(listOrder[index],
                        (param) {
                      Navigator.of(context).pop();
                      Get.toNamed(confirmationAcceptScreen, arguments: param)
                          .then((value) {
                        if (value != null) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            refreshKey?.currentState?.show();
                          });
                        }
                      });
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(height: 70),
            Expanded(
              child: RefreshIndicator(
                key: refreshSearch,
                onRefresh: actionRefreshSearch,
                child: Container(),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: TextField(
                    controller: textSearchController,
                    onSubmitted: onSubmitSearch,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffEEEEEE),
                      contentPadding: EdgeInsets.only(top: 15.0),
                      hintText: 'Cari Pesanan Anda',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffC8C8C8), width: 2.0),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                          topLeft: Radius.circular(5.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColor.redAT, width: 1),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: MyColor.redAT,
                      ),
                    ),
                  ),
                ),
              ),
              if (isSearch || (querySearch?.isNotEmpty ?? false))
                SizedBox(width: 10),
              if (isSearch || (querySearch?.isNotEmpty ?? false))
                CupertinoButton(
                  minSize: 0,
                  padding: EdgeInsets.zero,
                  child: Text(
                    'Batal',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: onCancelSearch,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
