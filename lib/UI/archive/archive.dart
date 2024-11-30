import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:janssendeliveryadmin/data/models/orders.dart';

class Archive extends StatelessWidget {
  const Archive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: FutureBuilder(
          future: FirebaseDatabase.instance.ref("orders").get(),
          builder: (c, snapshot) {
            if (snapshot.hasData == false) {
              return CircularProgressIndicator();
            } else {
              Map<String, dynamic> data =
                  jsonDecode(jsonEncode(snapshot.data!.value));
              final record = OrderModel.fromMap(data.values.first);
              print(record);
              return Text(data.length.toString());
            }
          }),
    );
  }
}

Future<List<OrderModel>> getdata() {
  Map<String, OrderModel> orders = {};
  return FirebaseDatabase.instance.ref("orders").get().then((onValue) {
    Map<String, dynamic> data = jsonDecode(jsonEncode(onValue.value));
    final record = OrderModel.fromMap(data);
    print(data);

    if (record.closed == true) {
      orders.addAll({record.id.toString(): record});
    }
    return orders.values.toList();
  });
}
