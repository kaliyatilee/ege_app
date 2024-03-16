import 'package:egerecords/models/productsModel.dart';
import 'package:egerecords/repository/products_repository.dart';
import 'package:flutter/material.dart';

class ProductsTile extends StatelessWidget {
  final Products _products;
  ProductsTile(this._products, {super.key});
  final TextEditingController quantityController = TextEditingController();

  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
              title: Text(
                _products.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Price: \$${_products.price}",
                    ),
                    Text("Instock:${_products.inStock}")
                  ]),
              trailing: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(_products.name?.toString() ?? ''),
                        content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Description: ${_products.description.toString() ?? ''}",
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Price : \$${_products.price}",
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Code: ${_products.code}",
                                textAlign: TextAlign.left,
                              ),
                            ]),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(context), // Close the dialog
                            child: const Text('Dismiss'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              deleteProductData(context,_products.id);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // Set the button color
                              // Add other style properties as needed
                            ),
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Set the background color
                ),
                child: const Text("view"),
              )),
        ],
      ),
    );
  }

  Future<void> addToCart(
      int id, int quantity, String title, String price) async {
    // final prefs = await SharedPreferences.getInstance();
    // double total = price * quantity;
    // List<String> productData = [id.toString(), quantity.toString(), title, price.toString(),total.toString()];
    // final productDataString = jsonEncode(productData);
    // await prefs.setString('products', productDataString);
  }
}
