import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  bool success;
  List<Product> list;
  String msg;

  ProductModel({
    required this.success,
    required this.list,
    required this.msg,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        success: json["success"],
        list: List<Product>.from(json["list"].map((x) => Product.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "msg": msg,
      };
}

class Product {
  String title;
  int price;
  String image;
  String type;

  Product({
    required this.title,
    required this.price,
    required this.image,
    required this.type,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        title: json["title"],
        price: json["price"],
        image: json["image"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "image": image,
        "type": type,
      };
}
