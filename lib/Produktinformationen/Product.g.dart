// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['productname'] as String,
    (json['price'] as num).toDouble(),
    json['description'] as String,
    json['category'] as String,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productname': instance.productname,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
    };
