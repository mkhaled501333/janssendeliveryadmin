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

  once() {
    FirebaseDatabase.instance.ref("orders").get().then((onValue) {
      for (var element in onValue.children) {
        Map<String, dynamic> data = jsonDecode(jsonEncode(element.value));
        final record = OrderModel.fromMap(data);
        orders.addAll({record.id.toString(): record});
      }
      notifyListeners();
    });
  }

  update() {
    FirebaseDatabase.instance.ref("orders").onChildChanged.listen((onValue) {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(onValue.snapshot.value));
      final record = OrderModel.fromMap(data);
      orders.addAll({record.id.toString(): record});
      notifyListeners();
    });
    FirebaseDatabase.instance.ref("orders").onChildAdded.listen((onValue) {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(onValue.snapshot.value));
      final record = OrderModel.fromMap(data);
      orders.addAll({record.id.toString(): record});
      notifyListeners();
    });
  }

  int v = 88;
}

class RemoteDataSorce extends ChangeNotifier {}
