import 'package:aksestokomobile/main_common.dart';
import 'package:aksestokomobile/model/login_model.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:aksestokomobile/view_model/login/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

abstract class LoginScreenController extends LoginViewModel {
  showDialogProgress() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[CupertinoActivityIndicator()],
            ),
          );
        });
    await actionSubmit();
  }

  debugOnly(Widget child) {
    if (isProdMode) return child;
    var login = [
      Login(username: '900000010', password: 'Indonesia2020'),
      Login(username: '000001597', password: 'Indonesia1'),
      Login(username: '000000000', password: 'Indonesia1'),
      Login(username: '220000011', password: 'Indonesia12'),
      Login(username: '100021595', password: 'Indonesia1'),
      Login(username: '900000001', password: 'Indonesia1'),
      Login(username: '121212157', password: 'Indonesia1'),
      Login(username: '010001111', password: 'Indonesia1'),
      Login(username: '202000221', password: 'Indonesia1'),
    ];
    return Material(
      child: PopupMenuButton<int>(
        child: child,
        itemBuilder: (BuildContext context) => login
            .mapIndexed((e, i) => PopupMenuItem<int>(
          child: Text(e.username),
          value: i,
        ))
            .toList(),
        onSelected: (int idx) {
          Future.delayed(Duration(milliseconds: 300)).then((value) {
            currentData = login[idx];
            debugLog('cek currentData ${currentData?.toJson()}');
            postLogin(skip: true);
          });
        },
      ),
    );
  }
}

Widget debugMode(Widget child, context) {
  if (isProd) return child;
  var mode = [
    'Production',
    'QA',
    'Debug',
  ];
  return Material(
    child: PopupMenuButton<int>(
      child: child,
      itemBuilder: (BuildContext context) => mode
          .mapIndexed((e, i) => PopupMenuItem<int>(
                child: Text(e),
                value: i,
              ))
          .toList(),
      onSelected: (int idx) {
        Future.delayed(Duration(milliseconds: 300)).then((value) {
          valDebug = idx;
          Phoenix.rebirth(context);
        });
      },
    ),
  );
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T f(E e, int i)) {
    var i = 0;
    return this.map((e) => f(e, i++));
  }
}
