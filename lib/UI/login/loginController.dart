import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:janssendeliveryadmin/data/models/cars.dart';

// import 'package:supabase_flutter/supabase_flutter.dart';
String? carNum;

class LoginController extends ChangeNotifier {
  bool loggedIn = false;

  login(String carnum, String password) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("cars/");
    final d = ref.orderByChild('carNum').equalTo(carnum);
    d.once().then((onValue) {
      final car =
          CarModel.fromJson(jsonEncode(onValue.snapshot.children.first.value));
      if (car.password == password) {
        loggedIn = true;
        carNum = car.carNum;
        notifyListeners();
      }
    });
  }
}
