import 'package:egerecords/models/expenseModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> submitLoginData(BuildContext context,String email, String password) async {
  var url = "https://c8c8-197-221-251-3.ngrok-free.app/api/mobile_login";
  try {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    print(response.body);
    if (response.statusCode == 302) {
      // Handle redirect manually
      String redirectUrl = response.headers['location']!;
      EasyLoading.dismiss();
      // You can choose to make another request to the redirect URL or handle it as needed.
    } else if (response.statusCode == 200) {
      // Handle success response
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        EasyLoading.showSuccess(responseData['message']);
        print('Data submitted successfully');
        
        // Save user information to SharedPreferences
        saveUserInfo(responseData['user']);
        
        // Navigate to Dashboard
        navigateToDashboard(context);
      } else {
        EasyLoading.showError(responseData['message']);
        print('Error submitting data');
      }
    } else {
      // Handle other status codes
      EasyLoading.showError("An Error Occurred");
      print('Error submitting data: ${response.body}');
      print('Error submitting data: ${response.statusCode}');
    }
  } catch (e) {
    // Handle network errors
    EasyLoading.showError("Connection Error");
    print('Error: $e');
  }
}


// Function to save user information to SharedPreferences
Future<void> saveUserInfo(Map<String, dynamic> userData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('user_id', userData['id']);
  prefs.setString('user_name', userData['name']);
  prefs.setString('user_email', userData['email']);
  prefs.setString('user_branch_id', userData['branch_id']);
  prefs.setString('branch_name',userData['branch_name']);
}

// Function to navigate to the Dashboard
void navigateToDashboard(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/dashboard');
}

void navigateToLogin(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/login');
}

void navigateToSales(BuildContext context){
  Navigator.pushReplacementNamed(context, '/sales');
}
void navigateToProducts(BuildContext context){
  Navigator.pushReplacementNamed(context, '/products');

}


Future<void> clearAllSharedPreferences(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  navigateToLogin(context);
}


// Function to check if user_id is present in SharedPreferences
  Future<int?> checkUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  Future<String?> getBranchId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_branch_id');

  }

   Future<String?> getBranchName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('branch_name');

  }

