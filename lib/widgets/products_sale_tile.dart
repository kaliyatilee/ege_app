import 'package:flutter/material.dart';
import 'package:egerecords/models/productsModel.dart';
import 'package:egerecords/repository/sales_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProductSaleTile extends StatefulWidget {
  final Products _products;

  ProductSaleTile(this._products, {Key? key}) : super(key: key);

  @override
  _ProductSaleTileState createState() => _ProductSaleTileState();
}

class _ProductSaleTileState extends State<ProductSaleTile> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
     super.initState();
    _amountController.text = widget._products.price;
  }
  // final _branchList = ['Harare', 'Murambinda growth point', 'Bulawayo', 'Uncle timz farm'];
  // String _selectedBranch = 'Harare';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget._products.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Price: \$${widget._products.price}",
            ),
            trailing: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(widget._products.name?.toString() ?? ''),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // DropdownButtonFormField<String>(
                          //   value: _selectedBranch,
                          //   items: _branchList.map((branch) => DropdownMenuItem<String>(
                          //     value: branch,
                          //     child: Text(branch),
                          //   )).toList(),
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _selectedBranch = value!;
                          //     });
                          //   },
                          //   decoration: const InputDecoration(
                          //     labelText: 'Branch',
                          //     border: OutlineInputBorder(),
                          //   ),
                          // ),
                          TextField(
                            controller: _quantityController,
                            decoration: const InputDecoration(labelText: 'Quantity'),
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            controller: _amountController,
                            decoration: const InputDecoration(labelText: 'Amount (USD)'),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context), // Close the dialog
                          child: const Text('Dismiss'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final quantity = int.parse(_quantityController.text); // Get the quantity
                            EasyLoading.show(status: 'Submitting ..');
                            submitSalesData(context,widget._products.id, quantity, widget._products.price);
                          },
                          child: const Text('Sale'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set the background color
              ),
              child: const Text("Make a sale"),
            ),
          ),
        ],
      ),
    );
  }
}
