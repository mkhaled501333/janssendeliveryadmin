import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Archive extends StatelessWidget {
  const Archive({super.key});

  @override
  Widget build(BuildContext context) {
    print('object676767');
    FirebaseDatabase.instance
        .ref("orders/")
        .orderByChild('closed')
        .equalTo(false)
        .get()
        .then((onValue) {
      print(onValue);
    });
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: FutureBuilder(
          future: FirebaseDatabase.instance
              .ref("orders/")
              .orderByChild('closed')
              .equalTo(false)
              .once()
              .then((onValue) {
            print(onValue);
          }),
          builder: (c, snapshot) {
            print(snapshot.hasData);
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return Text('data');
            }
          }),
    );
  }
}


//  Future<OrderModel> getdata(){
//   Map<String, OrderModel> orders = {};
//   return  FirebaseDatabase.instance
//         .ref("orders/")
//         .orderByChild('closed')
//         .equalTo(false)
//         .once()
//         .then((onValue) {
//       for (var element in onValue.snapshot.children) {
//         Map<String, dynamic> data = jsonDecode(jsonEncode(element.value));
//         final record = OrderModel.fromMap(data);
//         orders.addAll({record.id.toString(): record});
//       }
//       return orders.values.toList();
//     });
// }