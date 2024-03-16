import 'package:egerecords/models/salesModel.dart';
import 'package:egerecords/pages/sales/new_sale.dart';
import 'package:egerecords/repository/sales_repository.dart';
import 'package:egerecords/widgets/sale_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => __SalesPageStateState();
}

class __SalesPageStateState extends State<SalesPage> {
  final List<Sales> _sales = <Sales>[];
  bool hasInternet = true;
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
    listenForsales();
     _isLoading = true;
  }

  checkInternetConnectivity() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));
      setState(() {
        hasInternet = response.statusCode == 200;
      });
    } catch (e) {
      setState(() {
        hasInternet = false;
      });
    }
  }

  Future<void> _refresh_sales() async {
    setState(() {});

    try {
      List<Sales> sales = await getSales();
      setState(() {
        _sales.clear();
        _sales.addAll(sales);
      });
    } catch (e) {
      // Handle error if any
      setState(() {});
    }
  }

  void listenForsales() async {
    try {
      List<Sales> sales = await getSales();
      setState(() {
        _sales.addAll(sales);
         _isLoading = false;
      });
    } catch (e) {
      // Handle error if any
    }
  }

  void _filter_sales(String query) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sales"),
        actions: [
          FloatingActionButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewSale(),
              ),
            );
          },
          child: const Text("New"),),
             IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
             _refresh_sales();
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SalesSearchDelegate(_sales, _filter_sales),
              );
            },
          ),
        ]),
      body: RefreshIndicator(
        onRefresh: _refresh_sales,
        child: hasInternet
            ?  _isLoading // modify this line
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
                itemCount: _sales.length,
                itemBuilder: (context, index) => SalesTile(_sales[index]),
              )
            : const Center(
                child: Text("No internet access"),
              ),
      ),
    );
  }
}

class SalesSearchDelegate extends SearchDelegate<Sales> {
  final List<Sales> _sales;
  final Function(String) onSearch;

  SalesSearchDelegate(this._sales, this.onSearch);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearch(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return const CloseButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Sales> suggestions = query.isEmpty
        ? []
        : _sales
            .where(
                (tsumo) => tsumo.description.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => SalesTile(suggestions[index]),
    );
  }

  @override
  set query(String value) {
    super.query = value;
    onSearch(value);
  }
}
