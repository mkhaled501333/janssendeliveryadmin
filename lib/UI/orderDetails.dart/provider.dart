import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:janssendeliveryadmin/data/models/orders.dart';

class OrderProvider extends ChangeNotifier {
  Map<String, OrderModel> orders = {};
  int lastOrderNum = 0;
  getData() {
    // once();

    update();
  }

  once() {
    FirebaseDatabase.instance
        .ref("orders/")
        .orderByChild('closed')
        .equalTo('false')
        .once()
        .then((onValue) {
      print('once');

      for (var element in onValue.snapshot.children) {
        Map<String, dynamic> data = jsonDecode(jsonEncode(element.value));
        final record = OrderModel.fromMap(data);
        orders.addAll({record.id.toString(): record});
      }
      notifyListeners();
    });
  }

  update() {
    FirebaseDatabase.instance.ref("lastOrderNum").onValue.listen((onData) {
      lastOrderNum = onData.snapshot.value as int;
    });
    FirebaseDatabase.instance.ref("orders/").onChildChanged.listen((onValue) {
      print('onChildChanged');
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(onValue.snapshot.value));
      final record = OrderModel.fromMap(data);
      if (record.closed == true) {
        orders.removeWhere((k, v) => k == record.id.toString());
      } else {
        orders.addAll({record.id.toString(): record});
      }
      notifyListeners();
    });
    FirebaseDatabase.instance
        .ref("orders/")
        .orderByChild('closed')
        .equalTo(false)
        .onChildChanged
        .listen((onValue) {
      print('onChildChanged filterd');

      Map<String, dynamic> data =
          jsonDecode(jsonEncode(onValue.snapshot.value));
      final record = OrderModel.fromMap(data);
      if (record.closed == true) {
        orders.removeWhere((k, v) => k == record.id.toString());
      } else {
        orders.addAll({record.id.toString(): record});
      }
      notifyListeners();
    });
    FirebaseDatabase.instance
        .ref("orders/")
        .orderByChild('closed')
        .equalTo(false)
        .onChildAdded
        .listen((onValue) {
      print('onChildAdded');
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(onValue.snapshot.value));
      final record = OrderModel.fromMap(data);
      if (record.closed == true) {
        orders.removeWhere((k, v) => k == record.id.toString());
      } else {
        orders.addAll({record.id.toString(): record});
      }
      notifyListeners();
    });
  }

  updaterecord(OrderModel order) {
    FirebaseDatabase.instance.ref("orders/${order.id}").set(order.toMap());
  }

  archiveSelectedCar(String carNum) {
    List<OrderModel> r = [];
    r.addAll(orders.values.where((e) => e.carNum == carNum));

    for (var action in r) {
      action.closed = true;
    }
    for (var element in r) {
      updaterecord(element);
    }
  }

  int v = 88;
  refreshUi() {
    notifyListeners();
  }
}
