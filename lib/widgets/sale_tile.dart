import 'package:egerecords/models/salesModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class SalesTile extends StatelessWidget {
  final Sales _sales;
   SalesTile(this._sales, {super.key});
  final TextEditingController quantityController = TextEditingController();

  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
              title: Text(
                _sales.description,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Product: " + _sales.name,
              ),
              trailing: ElevatedButton(
                
                onPressed: () {
                 showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text(_sales.name?.toString() ?? ''),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
        children: <Widget>[
          Text("Description : " + _sales.description, textAlign: TextAlign.left),
          Text("Price : \$${_sales.price.toString() ?? ''}",textAlign:TextAlign.left),
          Text("Quantity : " + _sales.quantity, textAlign: TextAlign.left),
          Text("Total : \$${_sales.totalPayed.toString() ?? ''}",textAlign:TextAlign.left),
          Text("Capture By : " + _sales.code, textAlign: TextAlign.left)
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context), // Close the dialog
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {},
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
                  primary: Colors.blue, // Set the background color
                ),
                child: const Text('View'),
              )
              ),
        ],
      ),
    );
  }
  
  Future<void> addToCart(int id, int quantity, String title, double price)  async {
    final prefs = await SharedPreferences.getInstance();
    double total = price * quantity;
    List<String> productData = [id.toString(), quantity.toString(), title, price.toString(),total.toString()];
   

  }
  

}
