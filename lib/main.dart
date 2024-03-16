import 'package:egerecords/auth/login_page.dart';
import 'package:egerecords/pages/dashboard.dart';
import 'package:egerecords/pages/products/products.dart';
import 'package:egerecords/pages/sales/new_sale.dart';
import 'package:egerecords/pages/sales/sales.dart';
import 'package:egerecords/repository/auth_repository.dart';
import 'package:egerecords/widgets/constants.dart';
import 'package:flutter/material.dart' show BuildContext, CircularProgressIndicator, Colors, FutureBuilder, Image, Key, MaterialApp, StatelessWidget, Text, TextStyle, ThemeData, Widget, WidgetsFlutterBinding, runApp;
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(await MyApp.create());
}

class MyApp extends StatelessWidget {
  final Widget logo = Image.asset('assets/images/logo.png');

  MyApp({Key? key}) : super(key: key);

  static Future<MyApp> create() async {
    await SharedPreferences.getInstance();
    return MyApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Constants.myPrimaryColor),
      builder: EasyLoading.init(),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder(
          // Check if user_id is present in SharedPreferences
          future: checkUserId(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // If user_id is present, navigate to Dashboard; otherwise, navigate to LoginPage
              return snapshot.data != null ? const Dashboard() :  LoginPage();
            }
          },
        ),
        '/record_sale': (context) => const NewSale(),
        '/sales': (context) => const SalesPage(),
        '/dashboard': (context) => const Dashboard(),
        '/login': (context) =>  LoginPage(),
        '/products': (context) =>  const ProductsPage(),
      },
    );
  }

  
}
