// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class ItemModel {
  int ID;
  String name;
  int quantitiy;
  double price;
  ItemModel({
    required this.ID,
    required this.name,
    required this.quantitiy,
    required this.price,
  });

  ItemModel copyWith({
    int? ID,
    String? name,
    int? quantitiy,
    double? price,
  }) {
    return ItemModel(
      ID: ID ?? this.ID,
      name: name ?? this.name,
      quantitiy: quantitiy ?? this.quantitiy,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': ID,
      'name': name,
      'quantitiy': quantitiy,
      'price': price,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      ID: map['ID'] as int,
      name: map['name'] as String,
      quantitiy: map['quantitiy'] as int,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(ID: $ID, name: $name, quantitiy: $quantitiy, price: $price)';
  }

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;

    return other.ID == ID &&
        other.name == name &&
        other.quantitiy == quantitiy &&
        other.price == price;
  }

  @override
  int get hashCode {
    return ID.hashCode ^ name.hashCode ^ quantitiy.hashCode ^ price.hashCode;
  }
}
