import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:janssendeliveryadmin/data/models/orders.dart';

class OrderProvider extends ChangeNotifier {
  Map<String, OrderModel> orders = {};
  getData() {
    once();
    update();
  }

  once() {print('object11');
    FirebaseDatabase.instance
        .ref("orders/")
        .orderByChild('closed')
        .equalTo(false)
        .once()
        .then((onValue) {print('object');
      for (var element in onValue.snapshot.children) {
        Map<String, dynamic> data = jsonDecode(jsonEncode(element.value));
        final record = OrderModel.fromMap(data);
        orders.addAll({record.id.toString(): record});
      }
      notifyListeners();
    });
  }

  update() {print('object22');
    FirebaseDatabase.instance
        .ref("orders")
        // .orderByChild('closed')
        // .equalTo(false)
        .onChildChanged
        .listen((onValue) {
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
