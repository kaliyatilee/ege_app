import 'package:egerecords/models/productsModel.dart';
import 'package:egerecords/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Products>> getProducts() async {
  //  var url = "https://egerecords.com/api/products";
  var url = "https://c8c8-197-221-251-3.ngrok-free.app/api/products";
  //  var url = "https://fakestoreapi.com/products";
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body.toString());
      final data = jsonResponse as List<dynamic>;
      return data.map((productJson) => Products.fromJson(productJson)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    throw Exception('Failed to load products');
  }
}

Future<void> submitProductData(BuildContext context ,String name,String description, double amount, String branch,
    String category, String instock, String code) async {
  var url = "https://c8c8-197-221-251-3.ngrok-free.app/api/add_product";
  var user_id = await checkUserId();
  try {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'description': description,
        'amount': amount,
        'branch': branch,
        'category': category,
        'in_stock': instock,
        'code': code,
        'name':name,
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
Future<void> deleteProductData(BuildContext context ,product_id) async {
  var url = "https://c8c8-197-221-251-3.ngrok-free.app/api/delete_product";
  var user_id = await checkUserId();
  try {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'product_id': product_id,
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
