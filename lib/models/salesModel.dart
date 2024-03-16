class Sales {
  final int id;
  final String saleId;
  final String sellingPrice;
  final String quantity;
  final String totalPayed;
  final String name;
  final String description;
  final String price;
  final String code;
  final String dateSold;

  Sales({
    required this.id,
    required this.saleId,
    required this.sellingPrice,
    required this.quantity,
    required this.totalPayed,
    required this.name,
    required this.description,
    required this.price,
    required this.code,
    required this.dateSold,
  });

  factory Sales.fromJson(Map<String, dynamic> json) {
  return Sales(
    id: int.parse(json['id'].toString()),
    saleId: json['sale_id'] as String,
    sellingPrice: json['selling_price'],
    quantity: json['quantity'] as String,
    totalPayed: json['total_payed'] as String,
    name: json['name'] as String,
    description: json['description'],
    price: json['price'] as String,
    code: json['code'] as String,
    dateSold : json['date_sold'] as String
  );
}
}