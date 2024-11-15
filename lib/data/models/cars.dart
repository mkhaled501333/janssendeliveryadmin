// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class CarModel {
  int id;
  String carNum;
  String password;
  String carType;
  CarModel({
    required this.id,
    required this.carNum,
    required this.password,
    required this.carType,
  });

  CarModel copyWith({
    int? id,
    String? carNum,
    String? password,
    String? carType,
  }) {
    return CarModel(
      id: id ?? this.id,
      carNum: carNum ?? this.carNum,
      password: password ?? this.password,
      carType: carType ?? this.carType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'carNum': carNum,
      'password': password,
      'carType': carType,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'] as int,
      carNum: map['carNum'] as String,
      password: map['password'] as String,
      carType: map['carType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) =>
      CarModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CarModel(id: $id, carNum: $carNum, password: $password, carType: $carType)';
  }

  @override
  bool operator ==(covariant CarModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.carNum == carNum &&
        other.password == password &&
        other.carType == carType;
  }

  @override
  int get hashCode {
    return id.hashCode ^ carNum.hashCode ^ password.hashCode ^ carType.hashCode;
  }
}
