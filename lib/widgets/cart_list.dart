import 'package:flutter/material.dart';
import 'package:egerecords/models/cartModel.dart';

class CartListItem extends StatelessWidget {
  final Cart product;
  final Function onTap;
  final Function onAddToCart;
  final Function onRemoveQuantity;

  const CartListItem({
    required this.product,
    required this.onTap,
    required this.onAddToCart,
    required this.onRemoveQuantity, 
    required int key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Image.network(product.imageUrl, width: 80.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, style: const TextStyle(fontSize: 16.0)),
                  // Text(product.description, style: const TextStyle(fontSize: 14.0)),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: (){},
            ),
            Text(product.quantity.toString()),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: (){}
            ),
            Text(
              "${product.price.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
