import 'package:json_annotation/json_annotation.dart';
part 'Product.g.dart';

@JsonSerializable()
class Product{
  Product(this.productname, this.price, this.description, this.category, this.brand);
  String productname;
  double price;
  String description;
  String category;
  String brand;

  factory Product.fromJson(Map<String, dynamic?> json)=>_$ProductFromJson(json);

  Map<String, dynamic?> toJson()=>_$ProductToJson(this);
}