import 'dart:convert';
import 'dart:ffi';

import 'package:egerecords/models/expenseModel.dart';
import 'package:egerecords/repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class ExpensesTile extends StatelessWidget {
  final Expenses _expenses;
   ExpensesTile(this._expenses, {super.key});
  final TextEditingController quantityController = TextEditingController();

  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
              title: Text(
                _expenses.description,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Amount: \$${_expenses.amount}",
              ),
              trailing: ElevatedButton(
                
           onPressed: () {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          _expenses.description?.toString() ?? '',
          textAlign: TextAlign.left,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Amount: \$${_expenses.amount.toString() ?? ''}",
              textAlign: TextAlign.left,
            ),
            Text(
              "Date : ${_expenses.date_captured}",
              textAlign: TextAlign.left,
            ),
            Text(
              "Capture By: ${_expenses.name}",
              textAlign: TextAlign.left,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context), // Close the dialog
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              deleteExpenseData(context,_expenses.id.toString());
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
    final productDataString = jsonEncode(productData);
    await prefs.setString('Expenses', productDataString);

  }
  

}
