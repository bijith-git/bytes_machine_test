class Product {
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

  String image;
  int price;
  String title;
  String type;

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "image": image,
        "type": type,
      };
}
