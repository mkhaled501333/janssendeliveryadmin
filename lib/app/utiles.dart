import 'package:intl/intl.dart';

extension Dsd on DateTime {
  String formatt_yMd() {
    String formateeddate = DateFormat('dd.MM.yyyy').format(this);
    return formateeddate;
  }

  String formatt_yMdHM() {
    String formateeddate = DateFormat('dd.MM.yyyy hh:mm a').format(this);
    return formateeddate;
  }

  // int formatt_toint() {
  //   String formateeddate = DateFormat('ddMMyyyy').format(this);
  //   return formateeddate.to_int();
  // }

  String formatt_hms() {
    String formateeddate = DateFormat('hh:mm:ss a').format(this);
    return formateeddate;
  }
}

extension D on String {
  int toInt() {
    return int.parse(this);
  }
}

extension Dd on String {
  double todouble() {
    return double.parse(this);
  }
}
