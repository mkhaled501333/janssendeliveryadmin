// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class ItemModel {
  int id;
  String brand;
  String name;
  num quantitiy;
  num requiredcharged;
  num price;
  ItemModel({
    required this.id,
    required this.brand,
    required this.name,
    required this.quantitiy,
    required this.requiredcharged,
    required this.price,
  });


  ItemModel copyWith({
    int? id,
    String? brand,
    String? name,
    num? quantitiy,
    num? requiredcharged,
    num? price,
  }) {
    return ItemModel(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      name: name ?? this.name,
      quantitiy: quantitiy ?? this.quantitiy,
      requiredcharged: requiredcharged ?? this.requiredcharged,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'brand': brand,
      'name': name,
      'quantitiy': quantitiy,
      'requiredcharged': requiredcharged,
      'price': price,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as int,
      brand: map['brand'] as String,
      name: map['name'] as String,
      quantitiy: map['quantitiy'] as num,
      requiredcharged: map['requiredcharged'] as num,
      price: map['price'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(id: $id, brand: $brand, name: $name, quantitiy: $quantitiy, requiredcharged: $requiredcharged, price: $price)';
  }

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.brand == brand &&
      other.name == name &&
      other.quantitiy == quantitiy &&
      other.requiredcharged == requiredcharged &&
      other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      brand.hashCode ^
      name.hashCode ^
      quantitiy.hashCode ^
      requiredcharged.hashCode ^
      price.hashCode;
  }
}
