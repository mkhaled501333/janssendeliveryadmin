import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// import 'package:supabase_flutter/supabase_flutter.dart';
String? carNum;

class LoginController extends ChangeNotifier {
  bool loggedIn = false;

  login(String carnum, String password) async {
    FirebaseDatabase.instance.ref("adminpass").get().then((val) {
      if (carnum == 'admin' && val.value == password) {
        loggedIn = true;
        notifyListeners();
      }
    });
  }
}
