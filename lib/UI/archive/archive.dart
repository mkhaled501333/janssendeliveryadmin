import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssendeliveryadmin/UI/orderDetails.dart/statuesWidgets.dart';
import 'package:janssendeliveryadmin/app/utiles.dart';
import 'package:janssendeliveryadmin/data/models/orders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Archive extends StatelessWidget {
  const Archive({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, OrderModel> orders = {};

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: Builder(builder: (context) {
        return FutureBuilder(
            future: FirebaseDatabase.instance
                .ref("orders/")
                .orderByChild('closed')
                .equalTo(true)
                .get(),
            builder: (c, snapshot) {
              if (snapshot.hasData == false) {
                return const CircularProgressIndicator();
              } else {
                for (var element in snapshot.data!.children) {
                  final order = OrderModel.fromJson(jsonEncode(element.value));
                  orders.addAll({order.id.toString(): order});
                }
                return DataGridForArchiveOrdesr(orders: orders.values.toList());
              }
            });
      }),
    );
  }
}

final ValueNotifier<int> counter = ValueNotifier<int>(0);
final DataGridController _dataGridController = DataGridController();

String x = "0";

class DataGridForArchiveOrdesr extends StatelessWidget {
  const DataGridForArchiveOrdesr({super.key, required this.orders});
  final List<OrderModel> orders;
  final textstyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 13.7,
      color: Color.fromARGB(255, 112, 110, 110));
  @override
  Widget build(BuildContext context) {
    final clients = orders.map((e) => e.clientName).toSet().toList().length;
    return SfDataGridTheme(
      data: const SfDataGridThemeData(
        gridLineStrokeWidth: 0.6,
      ),
      child: SfDataGrid(
        onSelectionChanged: (v, g) {
          counter.value = _dataGridController.selectedRows.length;
        },
        showCheckboxColumn: true,
        checkboxColumnSettings: const DataGridCheckboxColumnSettings(),
        selectionMode: SelectionMode.multiple,
        controller: _dataGridController,
        rowHeight: 25,
        frozenColumnsCount: 2,
        footerFrozenColumnsCount: 1,
        source: DataSource(data: orders.toList()),
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: true,
        allowMultiColumnSorting: true,
        allowFiltering: true,
        showSortNumbers: true,
        allowEditing: true,
        headerRowHeight: 30,
        headerGridLinesVisibility: GridLinesVisibility.both,
        isScrollbarAlwaysShown: true,
        showHorizontalScrollbar: true,
        gridLinesVisibility: GridLinesVisibility.horizontal,
        highlightRowOnHover: true,
        columns: <GridColumn>[
          GridColumn(
              allowFiltering: false,
              width: 111,
              columnName: 'id',
              label: Row(
                children: [
                  Text(
                    'Order No',
                    style: textstyle,
                  ),
                  const Gap(6),
                  ValueListenableBuilder<int>(
                    valueListenable: counter,
                    builder: (c, value, _) {
                      return Text(
                        '($value)',
                        style: textstyle,
                      );
                    },
                  ),
                ],
              )),
          GridColumn(
              allowFiltering: false,
              allowEditing: true,
              width: 80,
              columnName: 'orderdata',
              label: Center(
                child: Text(
                  ' Date',
                  style: textstyle,
                ),
              )),
          GridColumn(
              allowFiltering: true,
              allowEditing: true,
              width: 144,
              columnName: 'client',
              label: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 219, 219, 219),
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(clients.toString()),
                      ),
                    ),
                    const Gap(3),
                    Text(
                      'Client',
                      style: textstyle,
                    ),
                  ],
                ),
              )),
          GridColumn(
              allowFiltering: true,
              width: 112,
              columnName: 'governomate',
              label: Center(
                child: Text(
                  'Governomate',
                  style: textstyle,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              allowFiltering: true,
              width: 111,
              columnName: 'city',
              label: Center(
                child: Text(
                  'City',
                  overflow: TextOverflow.ellipsis,
                  style: textstyle,
                ),
              )),
          GridColumn(
              allowFiltering: false,
              width: 111,
              columnName: 'adress',
              label: Center(
                child: Text(
                  'Adress',
                  style: textstyle,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              allowFiltering: true,
              width: 111,
              columnName: 'carnum',
              label: Center(
                child: Text(
                  'CarNum',
                  style: textstyle,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              allowFiltering: true,
              width: 130,
              columnName: 'statues',
              label: Center(
                child: Text(
                  'Statues',
                  style: textstyle,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              allowFiltering: false,
              width: 111,
              columnName: 'location',
              label: Center(
                child: Text(
                  'Location',
                  style: textstyle,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              allowFiltering: false,
              width: 111,
              columnName: 'Paymentmethod',
              label: Tooltip(
                message: 'Payment method',
                child: Center(
                  child: Text(
                    'Payment method',
                    style: textstyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )),
          GridColumn(
              allowFiltering: false,
              width: 111,
              columnName: 'chargedamount',
              label: Tooltip(
                message: 'charged amount',
                child: Center(
                  child: Text(
                    'charged amount',
                    style: textstyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )),
          GridColumn(
              allowFiltering: false,
              width: 111,
              columnName: 'resonforrejection',
              label: Tooltip(
                message: 'Resons for Rejection',
                child: Center(
                  child: Text(
                    'Resons for Rejection',
                    style: textstyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )),
          GridColumn(
              allowFiltering: false,
              width: 111,
              columnName: 'passtocrm',
              label: Tooltip(
                message: 'pass to crm ?',
                child: Center(
                  child: Text(
                    'pass to crm ?',
                    style: textstyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )),
          GridColumn(
              allowFiltering: false,
              width: 111,
              columnName: 'notes',
              label: Center(
                child: Text(
                  'notes',
                  style: textstyle,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              allowFiltering: false,
              allowSorting: false,
              width: 66,
              columnName: '',
              label: const Icon(Icons.settings)),
        ],
      ),
    );
  }
}

class DataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  DataSource({required List<OrderModel> data}) {
    _employeeData = data
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.orderNum),
              DataGridCell<String>(
                  columnName: 'orderdata', value: e.orderDate.formatt_yMd()),
              DataGridCell<String>(columnName: 'client', value: e.clientName),
              DataGridCell<String>(
                  columnName: 'governomate', value: e.governomate),
              DataGridCell<String>(columnName: 'city', value: e.city),
              DataGridCell<String>(columnName: 'adress', value: e.adress),
              DataGridCell<String>(columnName: 'carnum', value: e.carNum),
              DataGridCell<String>(columnName: 'statues', value: getstatues(e)),
              DataGridCell<String>(
                  columnName: 'location', value: getlocation(e)),
              DataGridCell<String>(
                  columnName: 'Paymentmethod', value: e.payingWay),
              DataGridCell<num>(
                  columnName: 'chargedamount', value: e.chargedamount),
              DataGridCell<String>(
                  columnName: 'resonforrejection', value: e.cancelReason),
              DataGridCell<String>(
                  columnName: 'passtocrm', value: e.notestocrm),
              DataGridCell<String>(columnName: 'notes', value: e.notes),
              DataGridCell<bool>(columnName: 'archived', value: e.canceled),
            ]))
        .toList();
  }

  String getstatues(OrderModel e) {
    if (e.deleverd == true) {
      return "deleverd";
    } else if (e.canceled == true) {
      return "canceld";
    } else {
      return "inProgress";
    }
  }

  String getlocation(OrderModel e) {
    if (e.deleverd == true) {
      return "deleverd";
    } else if (e.canceled == true) {
      return "canceld";
    } else {
      return "inProgress";
    }
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: const Color.fromARGB(255, 244, 244, 244),
        cells: row.getCells().map<Widget>((e) {
          return switch (e.columnName) {
            "id" => Row(
                children: [
                  Builder(builder: (context) {
                    return TextButton(
                        onPressed: () {
                          // context.read<OrderProvider>().refreshUi();
                          // context.read<SharedProvider>().x =
                          //     row.getCells().first.value.toString().toInt();
                          // Scaffold.of(context).openEndDrawer();

                          // print(context.read<OrderProvider>().v);
                        },
                        child: Text(e.value.toString()));
                  }),
                ],
              ),
            "location" => Builder(builder: (context) {
                return e.value.toString() == "deleverd"
                    ? IconButton(
                        icon: const Icon(
                          Icons.location_on,
                          size: 15,
                        ),
                        onPressed: () {},
                      )
                    : const SizedBox();
              }),
            "passtocrm" => Builder(builder: (context) {
                return e.value.toString() == ""
                    ? const SizedBox()
                    : Tooltip(
                        message: e.value.toString(),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 2,
                          ),
                        ),
                      );
              }),
            "statues" => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: switch (e.value.toString()) {
                  "deleverd" => const Deliverd(),
                  "canceld" => const Cancelled(),
                  "inProgress" => const InProgress(),
                  _ => const SizedBox()
                },
              ),
            _ => Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0.0),
                child: Tooltip(
                    message: e.value.toString(),
                    child: Text(
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                      e.value.toString(),
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
          };
        }).toList());
  }
}
