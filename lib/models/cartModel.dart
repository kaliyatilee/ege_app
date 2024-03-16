class Cart {
  final int id;
  final int quantity;
  final String title;
  final double price;
  final double total;

  const Cart({
    required this.id,
    required this.quantity,
    required this.title,
    required this.price,
    required this.total,
  });

  // Optional methods based on your needs:

  double calculateSubTotal() {
    return quantity * price;
  }

  @override
  String toString() {
    return 'Cart(id: $id, quantity: $quantity, title: $title, price: $price, total: $total)';
  }
}