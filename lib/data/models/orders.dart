// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:janssendeliveryadmin/data/models/item.dart';
import 'package:janssendeliveryadmin/data/models/location.dart';

class OrderModel {
  int id;
  int orderNum;
  DateTime orderDate;
  int carNum;
  String driverName;
  String driverPhoneNum;
  String represetiveName;
  String represntivePhoneNum;
  // cleint
  String clientName;
  String phoneNum;
  String governomate;
  String city;
  String adress;
  List<ItemModel> items;
  //shipping
  bool shipped;
  DateTime shippedTime;
  Location shippedLocation;
  //actions on order
//1
  bool deleverd;
  Location deleverdLocation;
  DateTime deleverdTime;
  //2
  bool canceled;
  String cancelReason;
  DateTime canceltime;
//3
  bool closed;
  DateTime closedTime;
  //4
  bool payed;
  String payingWay;
  double chargedamount;
  //
  String notes;
  OrderModel({
    required this.id,
    required this.orderNum,
    required this.orderDate,
    required this.carNum,
    required this.driverName,
    required this.driverPhoneNum,
    required this.represetiveName,
    required this.represntivePhoneNum,
    required this.clientName,
    required this.phoneNum,
    required this.governomate,
    required this.city,
    required this.adress,
    required this.items,
    required this.shipped,
    required this.shippedTime,
    required this.shippedLocation,
    required this.deleverd,
    required this.deleverdLocation,
    required this.deleverdTime,
    required this.canceled,
    required this.cancelReason,
    required this.canceltime,
    required this.closed,
    required this.closedTime,
    required this.payed,
    required this.payingWay,
    required this.chargedamount,
    required this.notes,
  });

  OrderModel copyWith({
    int? id,
    int? orderNum,
    DateTime? orderDate,
    int? carNum,
    String? driverName,
    String? driverPhoneNum,
    String? represetiveName,
    String? represntivePhoneNum,
    String? clientName,
    String? phoneNum,
    String? governomate,
    String? city,
    String? adress,
    List<ItemModel>? items,
    bool? shipped,
    DateTime? shippedTime,
    Location? shippedLocation,
    bool? deleverd,
    Location? deleverdLocation,
    DateTime? deleverdTime,
    bool? canceled,
    String? cancelReason,
    DateTime? canceltime,
    bool? closed,
    DateTime? closedTime,
    bool? payed,
    String? payingWay,
    double? chargedamount,
    String? notes,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderNum: orderNum ?? this.orderNum,
      orderDate: orderDate ?? this.orderDate,
      carNum: carNum ?? this.carNum,
      driverName: driverName ?? this.driverName,
      driverPhoneNum: driverPhoneNum ?? this.driverPhoneNum,
      represetiveName: represetiveName ?? this.represetiveName,
      represntivePhoneNum: represntivePhoneNum ?? this.represntivePhoneNum,
      clientName: clientName ?? this.clientName,
      phoneNum: phoneNum ?? this.phoneNum,
      governomate: governomate ?? this.governomate,
      city: city ?? this.city,
      adress: adress ?? this.adress,
      items: items ?? this.items,
      shipped: shipped ?? this.shipped,
      shippedTime: shippedTime ?? this.shippedTime,
      shippedLocation: shippedLocation ?? this.shippedLocation,
      deleverd: deleverd ?? this.deleverd,
      deleverdLocation: deleverdLocation ?? this.deleverdLocation,
      deleverdTime: deleverdTime ?? this.deleverdTime,
      canceled: canceled ?? this.canceled,
      cancelReason: cancelReason ?? this.cancelReason,
      canceltime: canceltime ?? this.canceltime,
      closed: closed ?? this.closed,
      closedTime: closedTime ?? this.closedTime,
      payed: payed ?? this.payed,
      payingWay: payingWay ?? this.payingWay,
      chargedamount: chargedamount ?? this.chargedamount,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderNum': orderNum,
      'orderDate': orderDate.millisecondsSinceEpoch,
      'carNum': carNum,
      'driverName': driverName,
      'driverPhoneNum': driverPhoneNum,
      'represetiveName': represetiveName,
      'represntivePhoneNum': represntivePhoneNum,
      'clientName': clientName,
      'phoneNum': phoneNum,
      'governomate': governomate,
      'city': city,
      'adress': adress,
      'items': items.map((x) => x.toMap()).toList(),
      'shipped': shipped,
      'shippedTime': shippedTime.millisecondsSinceEpoch,
      'shippedLocation': shippedLocation.toMap(),
      'deleverd': deleverd,
      'deleverdLocation': deleverdLocation.toMap(),
      'deleverdTime': deleverdTime.millisecondsSinceEpoch,
      'canceled': canceled,
      'cancelReason': cancelReason,
      'canceltime': canceltime.millisecondsSinceEpoch,
      'closed': closed,
      'closedTime': closedTime.millisecondsSinceEpoch,
      'payed': payed,
      'payingWay': payingWay,
      'chargedamount': chargedamount,
      'notes': notes,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      orderNum: map['orderNum'] as int,
      orderDate: DateTime.fromMillisecondsSinceEpoch(map['orderDate'] as int),
      carNum: map['carNum'] as int,
      driverName: map['driverName'] as String,
      driverPhoneNum: map['driverPhoneNum'] as String,
      represetiveName: map['represetiveName'] as String,
      represntivePhoneNum: map['represntivePhoneNum'] as String,
      clientName: map['clientName'] as String,
      phoneNum: map['phoneNum'] as String,
      governomate: map['governomate'] as String,
      city: map['city'] as String,
      adress: map['adress'] as String,
      items: List<ItemModel>.from(
        (map['items'] as List<dynamic>).map<ItemModel>(
          (x) => ItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      shipped: map['shipped'] as bool,
      shippedTime:
          DateTime.fromMillisecondsSinceEpoch(map['shippedTime'] as int),
      shippedLocation:
          Location.fromMap(map['shippedLocation'] as Map<String, dynamic>),
      deleverd: map['deleverd'] as bool,
      deleverdLocation:
          Location.fromMap(map['deleverdLocation'] as Map<String, dynamic>),
      deleverdTime:
          DateTime.fromMillisecondsSinceEpoch(map['deleverdTime'] as int),
      canceled: map['canceled'] as bool,
      cancelReason: map['cancelReason'] as String,
      canceltime: DateTime.fromMillisecondsSinceEpoch(map['canceltime'] as int),
      closed: map['closed'] as bool,
      closedTime: DateTime.fromMillisecondsSinceEpoch(map['closedTime'] as int),
      payed: map['payed'] as bool,
      payingWay: map['payingWay'] as String,
      chargedamount: map['chargedamount'] as double,
      notes: map['notes'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(id: $id, orderNum: $orderNum, orderDate: $orderDate, carNum: $carNum, driverName: $driverName, driverPhoneNum: $driverPhoneNum, represetiveName: $represetiveName, represntivePhoneNum: $represntivePhoneNum, clientName: $clientName, phoneNum: $phoneNum, governomate: $governomate, city: $city, adress: $adress, items: $items, shipped: $shipped, shippedTime: $shippedTime, shippedLocation: $shippedLocation, deleverd: $deleverd, deleverdLocation: $deleverdLocation, deleverdTime: $deleverdTime, canceled: $canceled, cancelReason: $cancelReason, canceltime: $canceltime, closed: $closed, closedTime: $closedTime, payed: $payed, payingWay: $payingWay, chargedamount: $chargedamount, notes: $notes)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.orderNum == orderNum &&
        other.orderDate == orderDate &&
        other.carNum == carNum &&
        other.driverName == driverName &&
        other.driverPhoneNum == driverPhoneNum &&
        other.represetiveName == represetiveName &&
        other.represntivePhoneNum == represntivePhoneNum &&
        other.clientName == clientName &&
        other.phoneNum == phoneNum &&
        other.governomate == governomate &&
        other.city == city &&
        other.adress == adress &&
        listEquals(other.items, items) &&
        other.shipped == shipped &&
        other.shippedTime == shippedTime &&
        other.shippedLocation == shippedLocation &&
        other.deleverd == deleverd &&
        other.deleverdLocation == deleverdLocation &&
        other.deleverdTime == deleverdTime &&
        other.canceled == canceled &&
        other.cancelReason == cancelReason &&
        other.canceltime == canceltime &&
        other.closed == closed &&
        other.closedTime == closedTime &&
        other.payed == payed &&
        other.payingWay == payingWay &&
        other.chargedamount == chargedamount &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderNum.hashCode ^
        orderDate.hashCode ^
        carNum.hashCode ^
        driverName.hashCode ^
        driverPhoneNum.hashCode ^
        represetiveName.hashCode ^
        represntivePhoneNum.hashCode ^
        clientName.hashCode ^
        phoneNum.hashCode ^
        governomate.hashCode ^
        city.hashCode ^
        adress.hashCode ^
        items.hashCode ^
        shipped.hashCode ^
        shippedTime.hashCode ^
        shippedLocation.hashCode ^
        deleverd.hashCode ^
        deleverdLocation.hashCode ^
        deleverdTime.hashCode ^
        canceled.hashCode ^
        cancelReason.hashCode ^
        canceltime.hashCode ^
        closed.hashCode ^
        closedTime.hashCode ^
        payed.hashCode ^
        payingWay.hashCode ^
        chargedamount.hashCode ^
        notes.hashCode;
  }
}
