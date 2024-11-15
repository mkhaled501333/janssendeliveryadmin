// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class ItemModel {
  int id;
  String name;
  num quantitiy;
  num price;
  ItemModel({
    required this.id,
    required this.name,
    required this.quantitiy,
    required this.price,
  });

  ItemModel copyWith({
    int? id,
    String? name,
    num? quantitiy,
    num? price,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantitiy: quantitiy ?? this.quantitiy,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'quantitiy': quantitiy,
      'price': price,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as int,
      name: map['name'] as String,
      quantitiy: map['quantitiy'] as num,
      price: map['price'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, quantitiy: $quantitiy, price: $price)';
  }

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.quantitiy == quantitiy &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ quantitiy.hashCode ^ price.hashCode;
  }
}
