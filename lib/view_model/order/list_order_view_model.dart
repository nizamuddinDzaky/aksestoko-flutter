import 'package:aksestokomobile/controller/parent_controller.dart';
import 'package:aksestokomobile/model/order.dart';
import 'package:aksestokomobile/model/order_model.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/order/list_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

abstract class ListOrderViewModel extends State<ListOrderScreen>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  List<Order> _listOrder;
  OrderModel orderModelDalamProses;
  final ParentController controller = Get.find();
  var scrollController = ScrollController();
  var isLoading = 0;
  int lastOffset;
  int limit = 10;
  bool isSearch = false;
  String querySearch;
  List<Order> _listSearch;
  TextEditingController textSearchController = TextEditingController();
  GlobalKey<RefreshIndicatorState> refreshSearch = GlobalKey();

  int get endScroll =>
      ((((lastOffset ?? 0) ~/ limit) == (listOrder.length ~/ limit)) &&
              isLoading == 0)
          ? 0
          : 1;

  List<Order> get listOrder => [
        ...(controller?.filter(widget?.status) ?? []),
        ...((isSearch ? _listSearch : _listOrder) ?? [])
      ];

  void onSubmitSearch(String query) {
    querySearch = query;
    refreshSearch.currentState.show();
  }

  void onCancelSearch() {
    isSearch = false;
    querySearch = null;
    lastOffset = -1;
    textSearchController.clear();
    setState(() {});
  }

  Future<void> actionRefreshSearch() async {
    isSearch = true;
    lastOffset = -1;
    await getListOrder(offset: 0);
  }

  Future<void> actionRefresh() async {
    lastOffset = null;
    await getListOrder(offset: 0);
    return Future.value();
  }

  getListOrder({int offset}) async {
    offset = offset ?? listOrder?.length ?? 0;
    if ((lastOffset ?? -1) == offset) {
      //limit the same request
      return;
    }
    isLoading = 1;
    lastOffset = offset;
    setState(() {});
    var status = widget.status;
    var request = await ApiClient.methodGet(ApiConfig.urlListOrder,
        params: {
          'offset': offset,
          'limit': limit,
          if (querySearch?.isNotEmpty ?? false) 'search': querySearch,
        },
        onBefore: (status) {}, onSuccess: (data, flag) {
          _listOrder = _listOrder ?? [];
          _listSearch = _listSearch ?? [];
          if (lastOffset <= 0) {
            if (isSearch) {
              _listSearch?.clear();
            } else {
              _listOrder?.clear();
            }
          }
          if (data['data'][status] is Map) {
            orderModelDalamProses = OrderModel.fromJson(data['data'][status]);
            if (isSearch) {
              _listSearch.addAll(orderModelDalamProses.listOrderDalamProses);
            } else {
              _listOrder.addAll(orderModelDalamProses.listOrderDalamProses);
            }
          } else {
            if (isSearch) {
              lastOffset = _listSearch.length;
            } else {
              lastOffset = _listOrder.length;
            }
          }
      controller.clearOrder();
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {
      isLoading = 0;
    });
    if (mounted)
      setState(() {
        request.execute();
      });
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getListOrder();
      }
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshKey?.currentState?.show();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
