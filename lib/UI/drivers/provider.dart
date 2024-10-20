import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:janssendeliveryadmin/data/models/cars.dart';

class DriversProvider extends ChangeNotifier {
  Map<String, CarModel> cars = {};
  getData() {
    once();
    update();
  }

  once() {
    FirebaseDatabase.instance.ref("cars").get().then((onValue) {
      for (var element in onValue.children) {
        Map<String, dynamic> data = jsonDecode(jsonEncode(element.value));
        final record = CarModel.fromMap(data);
        cars.addAll({record.id.toString(): record});
      }
      notifyListeners();
    });
  }

  update() {
    FirebaseDatabase.instance.ref("cars").onChildChanged.listen((onValue) {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(onValue.snapshot.value));
      final record = CarModel.fromMap(data);
      cars.addAll({record.id.toString(): record});
      notifyListeners();
    });
    FirebaseDatabase.instance.ref("cars").onChildAdded.listen((onValue) {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(onValue.snapshot.value));
      final record = CarModel.fromMap(data);
      cars.addAll({record.id.toString(): record});
      notifyListeners();
    });
  }

  add(CarModel record) {
    FirebaseDatabase.instance.ref("cars/${record.id}").set(record.toMap());
    notifyListeners();
  }
}
