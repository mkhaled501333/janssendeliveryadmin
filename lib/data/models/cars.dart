import 'dart:convert';

class CarModel {
  int id;
  String carNum;
  String password;
  String carType;
  String? drivername;
  String? driverPhoneNum;
  String? representative;
  CarModel({
    required this.id,
    required this.carNum,
    required this.password,
    required this.carType,
    this.drivername,
    this.driverPhoneNum,
    this.representative,
  });

  CarModel copyWith({
    int? id,
    String? carNum,
    String? password,
    String? carType,
    String? drivername,
    String? driverPhoneNum,
    String? representative,
  }) {
    return CarModel(
      id: id ?? this.id,
      carNum: carNum ?? this.carNum,
      password: password ?? this.password,
      carType: carType ?? this.carType,
      drivername: drivername ?? this.drivername,
      driverPhoneNum: driverPhoneNum ?? this.driverPhoneNum,
      representative: representative ?? this.representative,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'carNum': carNum,
      'password': password,
      'carType': carType,
      'drivername': drivername,
      'driverPhoneNum': driverPhoneNum,
      'representative': representative,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'] as int,
      carNum: map['carNum'] as String,
      password: map['password'] as String,
      carType: map['carType'] as String,
      drivername:
          map['drivername'] != null ? map['drivername'] as String : null,
      driverPhoneNum: map['driverPhoneNum'] != null
          ? map['driverPhoneNum'] as String
          : null,
      representative: map['representative'] != null
          ? map['representative'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) =>
      CarModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CarModel(id: $id, carNum: $carNum, password: $password, carType: $carType, drivername: $drivername, driverPhoneNum: $driverPhoneNum, representative: $representative)';
  }

  @override
  bool operator ==(covariant CarModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.carNum == carNum &&
        other.password == password &&
        other.carType == carType &&
        other.drivername == drivername &&
        other.driverPhoneNum == driverPhoneNum &&
        other.representative == representative;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        carNum.hashCode ^
        password.hashCode ^
        carType.hashCode ^
        drivername.hashCode ^
        driverPhoneNum.hashCode ^
        representative.hashCode;
  }
}
