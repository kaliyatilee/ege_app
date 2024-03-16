import 'dart:async';
import 'dart:io';

import 'package:egerecords/models/salesModel.dart';
import 'package:egerecords/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
Future<List<Sales>> getSales() async {
  var url = "https://c8c8-197-221-251-3.ngrok-free.app/api/sales";
  try {
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
      final data = jsonResponse as List<dynamic>; 
      return data.map((salesJson) => Sales.fromJson(salesJson)).toList();
    } else {
      throw Exception('Failed to load sales');
    }
  } catch (e) {
    throw Exception('Failed to load sales');
  }
}

 Future<void> submitSalesData(BuildContext context,int id, int quantity, String price) async {
  var url = "https://c8c8-197-221-251-3.ngrok-free.app/api/add_sale";
  final branchId = await getBranchId();
  final userId = await checkUserId();
  print(branchId);
  print(userId);
  try {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'product_id': id,
        'quantity': quantity,
        'selling_price': price,
        'branch_id': branchId,
        'user_id': userId
      }),
    );


    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData['success']) {
        EasyLoading.showSuccess(responseData['message']);
        navigateToSales(context);
      } else {
        EasyLoading.showError(responseData['message']);
      }
    } else {
      // Handle server errors
      EasyLoading.showError("Server Error: ${response.statusCode}");
    }
  } catch (e) {
    // Handle different types of errors
    if (e is TimeoutException) {
      EasyLoading.showError("Connection Timed Out");
    } else if (e is SocketException) {
      EasyLoading.showError("Network Unreachable");
    } else {
      print("$e");
      EasyLoading.showError("Connection Error: $e");
    }
  }
}


 Future<void> deleteSaleData(BuildContext context ,sale_id) async {
  var url = "https://c8c8-197-221-251-3.ngrok-free.app/api/delete_product";
  var user_id = await checkUserId();
  try {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'sale_id': sale_id,
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
