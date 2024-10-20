import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssendeliveryadmin/UI/GoogleMap/GoogleMap.dart';
import 'package:janssendeliveryadmin/UI/bulkUploadOrders/bulkupload.dart';
import 'package:janssendeliveryadmin/UI/carDataGrid/carDataGrid.dart';
import 'package:janssendeliveryadmin/UI/drivers/drivers.dart';
import 'package:janssendeliveryadmin/UI/drivers/provider.dart';

import 'package:janssendeliveryadmin/UI/orderDetails.dart/dataGridForOrders.dart';
import 'package:janssendeliveryadmin/UI/orderDetails.dart/provider.dart';
import 'package:janssendeliveryadmin/UI/sharedProvider.dart';
import 'package:janssendeliveryadmin/app/utiles.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: 'janssendelivery',
    // demoProjectId: 'janssendelivery-ba129',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAbVWkXPlOSYWPfYlfQxwzg2G91fPkAnDU',
      appId: '1:1048077712638:web:1db5bc937b81d8354cf9af',
      messagingSenderId: '1048077712638',
      projectId: 'janssendelivery-ba129',
      databaseURL: "https://janssendelivery-ba129-default-rtdb.firebaseio.com",
      authDomain: "janssendelivery-ba129.firebaseapp.com",
      storageBucket: "janssendelivery-ba129.appspot.com",
    ),
  );
  // FirebaseDatabase.instance.setPersistenceEnabled(true);

  runApp(MyApp());

  // FirebaseDatabase.instance;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DriversProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SharedProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'admin',
        home: Scaffold(
          body: Builder(builder: (context) {
            context.read<OrderProvider>().getData();
            context.read<DriversProvider>().getData();
            return const SidebarPage();
          }),
        ),
      ),
    );
  }
}

class SidebarPage extends StatefulWidget {
  const SidebarPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  late List<CollapsibleItem> _items;
  late String _headline;

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Dashboard',
        icon: Icons.assessment,
        onPressed: () => setState(() => _headline = 'DashBoard'),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'upoad Orders',
        icon: Icons.upload,
        onPressed: () => setState(() => _headline = 'upload Orders'),
      ),
      CollapsibleItem(
        text: 'Settings',
        icon: Icons.settings,
        onPressed: () => setState(() => _headline = 'Settings'),
      ),
      CollapsibleItem(
        text: 'Analytics',
        icon: Icons.access_alarm,
        onPressed: () => setState(() => _headline = 'Analytics'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final x = switch (_headline) {
      "Dashboard" => const MyHomePage(),
      "upload Orders" => const bulkUploadOrders(),
      "Settings" => const Drivers(),
      "Analytics" => Text(_headline),
      _ => const MyHomePage(),
    };
    return SafeArea(
      child: CollapsibleSidebar(
        title: "Janssen delivery Admin",
        customContentPaddingLeft: 0,
        customItemOffsetX: 10,
        bottomPadding: 33,
        iconSize: 25,
        itemPadding: 0,
        screenPadding: 0,
        topPadding: 33,
        maxWidth: 140,
        minWidth: 45,
        borderRadius: 0,
        curve: Curves.decelerate,
        items: _items,
        collapseOnBodyTap: true,
        body: x,
        backgroundColor: Colors.black,
        selectedIconBox: Colors.black,
        selectedIconColor: const Color.fromARGB(255, 255, 102, 0),
        selectedTextColor: const Color.fromARGB(255, 255, 102, 0),
        textStyle: const TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle:
            const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        sidebarBoxShadow: [],
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Consumer<SharedProvider>(
        builder: (context, myType, child) {
          final order = context
              .read<OrderProvider>()
              .orders
              .values
              .firstWhere((test) => test.orderNum == myType.x);

          return Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 222,
            child: Column(
              children: [
                const Gap(15),
                Text(
                  "Order : ${myType.x}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  color: Colors.black,
                  width: 300,
                  height: .8,
                ),
                const Gap(6),
                One("client", order.clientName),
                Tow("order date", order.orderDate.formatt_yMd()),
                One("adress", order.adress),
                Tow("order date", order.orderDate.formatt_yMd()),
                ...order.items.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Container(
                        width: double.infinity,
                        decoration:
                            BoxDecoration(border: Border.all(width: .4)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.name,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text("Quantity : ${e.quantitiy}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[400])),
                            Text("Price : ${e.price}",
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * .6 - 45,
                  height: MediaQuery.of(context).size.height * .5,
                  child: DottedBorder(
                    color: const Color.fromARGB(255, 56, 73, 56),
                    strokeWidth: 1.5,
                    child: DataGridForcar(),
                  )),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .5,
                  child: DottedBorder(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    strokeWidth: 1.5,
                    child: const MapSample(),
                  )),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * .78 - 40,
                  height: MediaQuery.of(context).size.height * .5,
                  child: const DataGridForOrder()),
              SizedBox(
                width: MediaQuery.of(context).size.width * .2,
                child: const Right(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding One(String label, String data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 230, 227, 227),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            "$label : $data",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Padding Tow(String label, String data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            maxLines: 3,
            "$label : $data",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class Right extends StatelessWidget {
  const Right({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, myType, child) {
        final orders = myType.orders.values.toList();
        final deleverd = orders.where((e) => e.deleverd == true).length;
        final canceled = orders.where((e) => e.canceled == true).length;

        final a = orders.expand((e) => e.items).map((e) => e.price);
        final totalAmount = a.isEmpty ? 0.0 : a.reduce((a, b) => a + b);

        final b = orders.map((e) => e.chargedamount);
        final charged = b.isEmpty ? 0.0 : b.reduce((a, b) => a + b);

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(11),
            SizedBox(
              height: 30,
              width: 120,
              child: TextField(
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 4),
                    prefixIcon: const Icon(Icons.search_outlined),
                    hoverColor: Colors.orange,
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 180, 4)),
                        borderRadius: BorderRadius.circular(9)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 3)),
                    hintStyle: const TextStyle(
                      fontSize: 12,
                    ),
                    hintText: 'Find Order'),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Total Orders  : ${orders.length}"),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Deliverd          :$deleverd"),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: LinearPercentIndicator(
                            barRadius: const Radius.circular(9),
                            width: MediaQuery.of(context).size.width * .06,
                            animation: true,
                            lineHeight: 15.0,
                            animationDuration: 2500,
                            percent: deleverd / orders.length,
                            center: Text(
                              "${((deleverd / orders.length) * 100).toStringAsFixed(1)}%",
                              style: const TextStyle(fontSize: 13),
                            ),
                            progressColor:
                                const Color.fromARGB(255, 90, 187, 94),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Canceled        :$canceled"),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: LinearPercentIndicator(
                            barRadius: const Radius.circular(9),
                            width: MediaQuery.of(context).size.width * .06,
                            animation: true,
                            lineHeight: 15.0,
                            animationDuration: 2500,
                            percent: canceled / orders.length,
                            center: Text(
                              "${((canceled / orders.length) * 100).toStringAsFixed(1)}%",
                              style: const TextStyle(fontSize: 13),
                            ),
                            progressColor:
                                const Color.fromARGB(255, 90, 187, 94),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            "In Progress    :${orders.length - deleverd - canceled}"),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: LinearPercentIndicator(
                            barRadius: const Radius.circular(9),
                            width: MediaQuery.of(context).size.width * .06,
                            animation: true,
                            lineHeight: 15.0,
                            animationDuration: 2500,
                            percent: (orders.length - deleverd - canceled) /
                                orders.length,
                            center: Text(
                              "${(((orders.length - deleverd - canceled) / orders.length) * 100).toStringAsFixed(1)}%",
                              style: const TextStyle(fontSize: 13),
                            ),
                            progressColor:
                                const Color.fromARGB(255, 90, 187, 94),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Total amount  : $totalAmount"),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("charged          :$charged"),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("remain        :${totalAmount - charged}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
