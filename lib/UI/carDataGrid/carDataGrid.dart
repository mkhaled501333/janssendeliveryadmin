// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssendeliveryadmin/UI/orderDetails.dart/provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:janssendeliveryadmin/app/utiles.dart';
import 'package:janssendeliveryadmin/data/models/location.dart';
import 'package:janssendeliveryadmin/data/models/orders.dart';
import 'package:janssendeliveryadmin/UI/orderDetails.dart/statuesWidgets.dart';

final ValueNotifier<int> counter = ValueNotifier<int>(0);
final DataGridController _dataGridController = DataGridController();

class DataGridForcar extends StatelessWidget {
  DataGridForcar({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, myType, child) {
        final data = myType.orders.values.toList();
        final d = data
            .map(
              (e) => e.carNum,
            )
            .toSet()
            .toList()
            .map((e) {
          final x = data.firstWhere((test) => test.carNum == e);
          final y = data.where((test) => test.carNum == e);
          final totla = y.length;
          final deleverd = y.where((e) => e.deleverd == true).length;
          final canceld = y.where((e) => e.canceled == true).length;
          return DataModel(
              carnum: e,
              drivername: x.driverName,
              driverPhoneNum: x.driverPhoneNum,
              represintitivename: x.represetiveName,
              represintitivePhoneNum: x.represntivePhoneNum,
              totalOrder: totla,
              deleverd: deleverd,
              canceld: canceld,
              inprogress: totla - deleverd - canceld,
              starttime: x.shippedTime,
              startLocation: x.shippedLocation);
        }).toList();
        return SfDataGrid(
          // headerGridLinesVisibility: GridLinesVisibility.none,
          headerRowHeight: 50,

          onSelectionChanged: (v, g) {
            counter.value = _dataGridController.selectedRows.length;
            print(_dataGridController.selectedRows.length);
          },
          showCheckboxColumn: true,
          checkboxColumnSettings: const DataGridCheckboxColumnSettings(),
          selectionMode: SelectionMode.multiple,
          controller: _dataGridController,
          rowHeight: 22,
          frozenColumnsCount: 2,
          footerFrozenColumnsCount: 1,
          source: DataSource(data: d),
          columnWidthMode: ColumnWidthMode.fill,
          allowSorting: true,
          allowMultiColumnSorting: true,
          allowFiltering: true,
          showSortNumbers: true,
          allowEditing: true,
          columns: <GridColumn>[
            GridColumn(
                allowFiltering: false,
                width: 111,
                columnName: 'carnum',
                label: const Row(
                  children: [
                    Text(
                      'car Num',
                      style: TextStyle(fontSize: 13),
                    ),
                    Gap(6),
                    // ValueListenableBuilder<int>(
                    //   valueListenable: counter,
                    //   builder: (c, value, _) {
                    //     return Text(
                    //       '($value)',
                    //       style: const TextStyle(fontSize: 12),
                    //     );
                    //   },
                    // ),
                  ],
                )),
            GridColumn(
                allowFiltering: false,
                allowEditing: true,
                width: 111,
                columnName: 'drivername',
                label: const Text('Driver Name')),
            GridColumn(
                allowFiltering: true,
                allowEditing: true,
                width: 130,
                columnName: 'driverphone',
                label: const Text('driver phone')),
            GridColumn(
                allowFiltering: true,
                width: 150,
                columnName: 'Representative',
                label: const Text(
                  'Representative',
                  overflow: TextOverflow.ellipsis,
                )),
            GridColumn(
                allowFiltering: true,
                width: 111,
                columnName: 'Representativephone',
                label: const Text(
                  'Representative phone',
                  overflow: TextOverflow.ellipsis,
                )),
            GridColumn(
                allowFiltering: false,
                width: 111,
                columnName: 'totalorders',
                label: const Text(
                  'Total Orders',
                  overflow: TextOverflow.ellipsis,
                )),
            GridColumn(
                allowFiltering: true,
                width: 111,
                columnName: 'Deleverd',
                label: const Text(
                  'Deleverd',
                  overflow: TextOverflow.ellipsis,
                )),
            GridColumn(
                allowFiltering: true,
                width: 130,
                columnName: 'canceld',
                label: const Text(
                  'Canceld',
                  overflow: TextOverflow.ellipsis,
                )),
            GridColumn(
                allowFiltering: false,
                width: 111,
                columnName: 'inprogress',
                label: const Text(
                  'inprogress',
                  overflow: TextOverflow.ellipsis,
                )),
            GridColumn(
                allowFiltering: false,
                width: 111,
                columnName: 'starttime',
                label: const Text(
                  'Start Time',
                  overflow: TextOverflow.ellipsis,
                )),
            GridColumn(
                allowFiltering: false,
                width: 111,
                columnName: 'startlocation',
                label: const Text(
                  'Start Location',
                  overflow: TextOverflow.ellipsis,
                )),
            GridColumn(
                allowFiltering: false,
                allowSorting: false,
                width: 66,
                columnName: '',
                label: const Text(' ')),
          ],
        );
      },
    );
  }
}

class DataModel {
  int carnum;
  String drivername;
  String driverPhoneNum;
  String represintitivename;
  String represintitivePhoneNum;
  int totalOrder;
  int deleverd;
  int canceld;
  int inprogress;
  DateTime starttime;
  Location startLocation;
  DataModel({
    required this.carnum,
    required this.drivername,
    required this.driverPhoneNum,
    required this.represintitivename,
    required this.represintitivePhoneNum,
    required this.totalOrder,
    required this.deleverd,
    required this.canceld,
    required this.inprogress,
    required this.starttime,
    required this.startLocation,
  });
}

class DataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  DataSource({required List<DataModel> data}) {
    _employeeData = data
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'carnum', value: e.carnum),
              DataGridCell<String>(
                  columnName: 'drivername', value: e.drivername),
              DataGridCell<String>(
                  columnName: 'driverphone', value: e.driverPhoneNum),
              DataGridCell<String>(
                  columnName: 'Representative', value: e.represintitivename),
              DataGridCell<String>(
                  columnName: 'Representativephone',
                  value: e.represintitivePhoneNum),
              DataGridCell<int>(columnName: 'totalorders', value: e.totalOrder),
              DataGridCell<int>(columnName: 'Deleverd', value: e.deleverd),
              DataGridCell<int>(columnName: 'canceld', value: e.canceld),
              DataGridCell<int>(columnName: 'inprogress', value: e.inprogress),
              DataGridCell<String>(
                  columnName: 'starttime', value: e.starttime.formatt_yMdHM()),
              DataGridCell<Location>(
                  columnName: 'startlocation', value: e.startLocation),
              const DataGridCell<bool>(columnName: 'archived', value: false),
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
//  String getlocation(OrderModel e){
//     if(e.deleverdLocation){
//       return "deleverd";
//     }else if(e.canceled==true){return "canceld";}else{return "inProgress";}
//   }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: const Color.fromARGB(255, 250, 250, 250),
        cells: row.getCells().map<Widget>((e) {
          return switch (e.columnName) {
            "id" => Row(
                children: [
                  Builder(builder: (context) {
                    return TextButton(
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();

                          print(row.getCells().last.value.toString());
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
                child: Text(
                  e.value.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          };
        }).toList());
  }
}
