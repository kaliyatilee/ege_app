

import 'dart:ffi';

import 'package:egerecords/models/expenseModel.dart';
import 'package:egerecords/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
Future<List<Expenses>> getExpenses() async {
  // var url = "https://egerecords.com/api/expenses";
  var url = "https://c8c8-197-221-251-3.ngrok-free.app/api/expenses";
  try {
    // final response = await http.get(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Allow-Headers': 'Content-Type',
          'Access-Control-Allow-Methods':
          'GET,PUT,POST,DELETE'
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body.toString());
      print(jsonResponse);
      final data = jsonResponse as List<dynamic>; 
      return data.map((productJson) => Expenses.fromJson(productJson)).toList();
    } else {
      throw Exception('Failed to load Expense');
    }
  } catch (e) {
    throw Exception('Failed to load Expense');
  }
}
  Future<void> submitExpenseData(String description, double amount, String _selectedDate) async {
    var url = "https://c8c8-197-221-251-3.ngrok-free.app/api/add_expense";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'description': description,
          'amount': amount,
          'branch_id': getBranchId(),
          'date_captured':_selectedDate,
          'user_id':checkUserId()
        }),
      );
      if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        EasyLoading.showSuccess(responseData['message']);
      } else {
        EasyLoading.showError(responseData['message']);
      }
    } else {
      EasyLoading.showError("An Error Occurred");
    }
  } catch (e) {
    // Handle network errors
    EasyLoading.showError("Connection Error");
  }
  }

  Future<void> deleteExpenseData(BuildContext context ,String expense_id) async {
  var url = "https://c8c8-197-221-251-3.ngrok-free.app/api/delete_expense";
  var user_id = await checkUserId();
  try {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'id': expense_id,
        'user_id': user_id
      }),
    );
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        EasyLoading.showSuccess(responseData['message']);
        navigateToProducts(context);
      } else {
        EasyLoading.showError(responseData['message']);
      }
    } else {
      EasyLoading.showError("An Error Occurred");
    }
  } catch (e) {
    // Handle network errors
    EasyLoading.showError("Connection Error"); 
  }
}



