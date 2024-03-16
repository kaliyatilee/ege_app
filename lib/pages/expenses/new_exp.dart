import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:egerecords/repository/expense_repository.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key}) : super(key: key);

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  // final _branchList = ['Harare', 'Murambinda growth point', 'Bulawayo', 'Uncle timz farm'];
  // String _selectedBranch = 'Harare';
  DateTime _selectedDate = DateTime.now();
  

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
          title: const Text("New Expense"),
          actions: [],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Purpose',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    hintText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateAmount,
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2040),
                    );
                    if (date != null) {
                      setState(() {
                        _selectedDate = date;
                      });
                    }
                  },
                  child: Text(
                    'Select Date: ${DateFormat('y-MM-dd').format(_selectedDate)}',
                  ),
                ),
                // const SizedBox(height: 16.0),
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
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final description = _descriptionController.text;
                      final amount = double.parse(_amountController.text);
                      // final branch = _selectedBranch;
                      final date = _selectedDate;
                      EasyLoading.show(status: "Submitting");
                     submitExpenseData(description, amount, date.toString());
                    }
                  },
                  child: const Text('Save Expense'),
                )
              ]),
            )));
  }
}
