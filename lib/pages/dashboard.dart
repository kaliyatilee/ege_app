import 'package:egerecords/pages/expenses/expenses.dart';
import 'package:egerecords/pages/products/products.dart';
import 'package:egerecords/pages/sales/sales.dart';
import 'package:egerecords/repository/auth_repository.dart';
import 'package:egerecords/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:egerecords/widgets/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool hasInternet = true;
   late String accountName = '';
  late String accountEmail = '';
  late String branchName = '';

  @override
  void initState() {
    super.initState();
    // Fetch account name and email when the widget is initialized
    fetchAccountInfo();
  }
   Future<void> fetchAccountInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accountName = prefs.getString('user_name') ?? 'EGE Records';
      accountEmail = prefs.getString('user_email') ?? 'info@egerecords.com';
      branchName = prefs.getString('branch_name') ?? 'EGE Records';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(branchName)),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
               UserAccountsDrawerHeader(
                  accountName: Text(accountName),
                  accountEmail: Text(accountEmail),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  )),
              ListTile(
                leading: const Icon(Icons.cast_for_education),
                title: const Text('Products'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductsPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.cast_for_education),
                title: const Text('Sales'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SalesPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.cast_for_education_outlined),
                title: const Text('Expenses'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExpensesPage(),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
                onTap: () {
                  // Handle navigation
                },
              ),
               ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Logout'),
                onTap: () {
                  clearAllSharedPreferences(context);
                  // Handle navigation
                },
              )
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            buildDashboardCard(
              context,
              icon: Icons.shopping_cart,
              title: 'Point of Sale',
              color: Constants.cardColors[0],
              routeName: '/record_sale',
            ),
            buildDashboardCard(
              context,
              icon: Icons.bar_chart,
              title: 'Today Sales Report',
              color: Constants.cardColors[1],
              routeName: '/sales',
            ),
            buildDashboardCard(
              context,
              icon: Icons.assignment,
              title: 'Inventory',
              color: Constants.cardColors[2],
              routeName: '/stocks',
            ),
            buildDashboardCard(
              context,
              icon: Icons.storage,
              title: 'Stocks',
              color: Constants.cardColors[3],
              routeName: '/stocks',
            ),
          ],
        ),
      ),
    );
  }
}
