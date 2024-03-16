import 'package:egerecords/repository/products_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:egerecords/repository/expense_repository.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({Key? key}) : super(key: key);

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _instockController = TextEditingController();
  final _branchList = ['Harare', 'Mutare', 'Murambinda', 'Bulawayo','Gweru','Uncle timz farm'];
  final _categoryList = ['Electronics', 'consoles', 'games', 'controllers'];
  String _selectedCategory = 'controllers';
  String _selectedBranch = 'Harare';
  
  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the amount';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Product"),
          actions: [],
        ),
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
                const SizedBox(height: 16.0),
                   Expanded(
                    child:DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: _categoryList.map((category) => DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                )),
                 const SizedBox(height: 16.0),
                Expanded(
                    child:DropdownButtonFormField<String>(
                  value: _selectedBranch,
                  items: _branchList.map((branch) => DropdownMenuItem<String>(
                    value: branch,
                    child: Text(branch),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBranch = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Branch',
                    border: OutlineInputBorder(),
                  ),
                )),
                const SizedBox(height: 16.0),
                Expanded(
                    child:TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                )),
                  const SizedBox(height: 16.0),
                Expanded(
                    child:TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                )),
                  const SizedBox(height: 16.0),
                Expanded(
                    child:TextFormField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: 'Product Code',
                    hintText: 'Product Code',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product code';
                    }
                    return null;
                  },
                )),
                const SizedBox(height: 16.0),
                Expanded(
                    child:TextFormField(
                  controller: _priceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateAmount,
                )),
                const SizedBox(height: 16.0),
                Expanded(
                    child:TextFormField(
                  controller: _instockController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    labelText: 'In Stock',
                    hintText: 'In stock',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateAmount,
                )),
               
               
                const SizedBox(height: 16.0),
                Expanded(
                    child:ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final description = _descriptionController.text;
                      final amount = double.parse(_priceController.text);
                      final branch = _selectedBranch;
                      final category = _selectedCategory;
                      final instock = _instockController.text;
                      final code = _codeController.text;
                      final name = _nameController.text;
                      EasyLoading.show(status: "Submitting");
                      submitProductData(context,name,description, amount, branch,category,instock,code);
                    }
                  },
                  child: const Text('Save Product'),
                )
      )]),
            )));
  }
}
