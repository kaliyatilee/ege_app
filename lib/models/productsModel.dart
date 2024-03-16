class Products {
  final int id;
  final String name;
  final String price;
  final String description;
  final String code;
  final String inStock;

  Products({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.code,
    required this.inStock,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
  return Products(
    id: int.parse(json['id'].toString()),
    name: json['name'] as String,
    price: json['price'],
    description: json['description'] as String,
    code: json['code'] as String,
    inStock : json['in_stock'] as String
  );
}
}