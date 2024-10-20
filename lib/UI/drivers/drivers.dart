import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssendeliveryadmin/UI/drivers/provider.dart';
import 'package:janssendeliveryadmin/data/models/cars.dart';
import 'package:provider/provider.dart';

class Drivers extends StatelessWidget {
  const Drivers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: Consumer<DriversProvider>(
        builder: (context, myType, child) {
          return Column(
            children: [
              InkWell(
                child: Ink(
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 255, 159, 0)
                              .withOpacity(0.8),
                          const Color.fromARGB(255, 255, 102, 0)
                              .withOpacity(0.8),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline_outlined,
                            color: Colors.white,
                          ),
                          Gap(4),
                          Text(
                            "Add Car",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )),
                onTap: () {
                  TextEditingController carnum = TextEditingController();
                  TextEditingController pass = TextEditingController();
                  TextEditingController t = TextEditingController();
                  showDialog(
                      context: context,
                      builder: (c) => AlertDialog(
                            content: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 2,
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                        label: Text("Car Number")),
                                    controller: carnum,
                                  ),
                                  Gap(33),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        label: Text("password")),
                                    controller: pass,
                                  ),
                                  Gap(33),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        label: Text("carr type")),
                                    controller: t,
                                  ),
                                  Gap(33),
                                  ElevatedButton(
                                      onPressed: () {
                                        final record = CarModel(
                                            id: DateTime.now()
                                                .microsecondsSinceEpoch,
                                            carNum: carnum.text,
                                            password: pass.text,
                                            carType: t.text);
                                        myType.add(record);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Save"))
                                ],
                              ),
                            ),
                          ));
                },
              ),
              SingleChildScrollView(
                child: Center(
                  child: Table(
                    children: [
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade400, width: 0.7),
                              color: const Color.fromARGB(255, 255, 255, 255)),
                          children: const [
                            Text("Num"),
                            Text("car Num"),
                            Text("password"),
                            Text("car Type"),
                          ]),
                      ...myType.cars.values.map(
                        (e) => TableRow(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            children: [
                              const Text("Num"),
                              SelectableText(e.carNum.toString()),
                              SelectableText(e.password.toString()),
                              SelectableText(e.carType.toString()),
                            ]),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
