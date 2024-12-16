// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Uint8List;
import 'package:csv/csv.dart';
import 'package:gap/gap.dart';
import 'package:janssendeliveryadmin/UI/orderDetails.dart/provider.dart';
import 'package:janssendeliveryadmin/app/utiles.dart';
import 'package:janssendeliveryadmin/data/models/item.dart';
import 'package:janssendeliveryadmin/data/models/location.dart';
import 'package:janssendeliveryadmin/data/models/orders.dart';
import 'package:provider/provider.dart';

class bulkUploadOrders extends StatefulWidget {
  const bulkUploadOrders({super.key});

  @override
  State<bulkUploadOrders> createState() => _bulkUploadState();
}

class _bulkUploadState extends State<bulkUploadOrders> {
  List<List<dynamic>> _data = [];
  String? filePath;
  // This function is triggered when the  button is pressed
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    "هام:يجب ان يكون شيت الاكسل كالتالى ",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/1234.png',
                    width: MediaQuery.of(context).size.width - 46,
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: Ink(
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add_circle_outline_outlined,
                                    color: Colors.white,
                                  ),
                                  Gap(4),
                                  Text(
                                    "Upload File",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Gap(4),
                                  Icon(Icons.file_upload_outlined,
                                      color: Colors.white)
                                ],
                              ),
                            )),
                        onTap: () {
                          pickFile();
                        },
                      ),
                      const Gap(33),
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Color.fromARGB(255, 93, 197, 93))),
                        child: const Text(
                          " incert This Data",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                        onPressed: () {
                          int lastOrderNum =
                              context.read<OrderProvider>().lastOrderNum;
                          if (_data.isNotEmpty) {
                            _data.removeAt(0);

                            for (var e
                                in _data.map((e) => e[0]).toSet().toList()) {
                              lastOrderNum++;
                              var d = _data.where((test) => test[0] == e);
                              final record = OrderModel(
                                  id: DateTime.now().microsecondsSinceEpoch +
                                      e.toString().toInt(),
                                  orderNum: lastOrderNum,
                                  orderDate: DateTime.now(),
                                  carNum: d.first[1].toString(),
                                  driverName: d.first[2],
                                  driverPhoneNum: d.first[3].toString(),
                                  represetiveName: d.first[4],
                                  represntivePhoneNum: d.first[5],
                                  clientName: d.first[6],
                                  phoneNum: d.first[7],
                                  governomate: d.first[8],
                                  city: d.first[9],
                                  adress: d.first[10],
                                  items: d
                                      .map((r) => ItemModel(
                                          id: DateTime.now()
                                                  .microsecondsSinceEpoch +
                                              r[13].toString().toInt(),
                                          name: r[11],
                                          quantitiy: r[12].toString().toInt(),
                                          price: r[13]
                                              .toString()
                                              .toInt()
                                              .toDouble()
                                              .toStringAsFixed(1)
                                              .todouble()))
                                      .toList(),
                                  shipped: false,
                                  shippedTime: DateTime(0),
                                  shippedLocation: Location(lat: "", lon: ""),
                                  deleverd: false,
                                  deleverdLocation: Location(lat: "", lon: ""),
                                  deleverdTime: DateTime(0),
                                  canceled: false,
                                  cancelReason: "",
                                  canceltime: DateTime(0),
                                  closed: false,
                                  closedTime: DateTime(0),
                                  payed: false,
                                  payingWay: "",
                                  chargedamount: 0.0,
                                  passtocrm: false,
                                  notestocrm: '',
                                  notes: "");

                              FirebaseDatabase.instance
                                  .ref("orders/${record.id}")
                                  .set(record.toMap());
                            }
                          }
                          FirebaseDatabase.instance
                              .ref("lastOrderNum")
                              .set(lastOrderNum);
                          setState(() {
                            _data.clear();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Table(
                    border: TableBorder.all(),
                    children: _data
                        .map((e) => TableRow(
                            children:
                                e.map((f) => Center(child: Text(f))).toList()))
                        .toList(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      List<List<dynamic>> rowdetail = [];

      Uint8List? bytes = result.files.single.bytes;
      Excel excel = Excel.decodeBytes(bytes!);
      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          rowdetail.addAll([row.map((e) => e!.value.toString()).toList()]);
        }
      }

      print(rowdetail);
      setState(() {
        _data = rowdetail;
      });
    } else {
      print("No file selected");
    }
  }

  // ignore: unused_element
  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    filePath = result.files.single.path!;

    final input = File(filePath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    print(fields);

    setState(() {
      _data = fields;
    });
  }
}
