import 'package:egerecords/models/productsModel.dart';
import 'package:egerecords/pages/products/add_new_prod.dart';
import 'package:egerecords/repository/products_repository.dart';
import 'package:egerecords/widgets/products_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => __ProductsPageStateState();
}

class __ProductsPageStateState extends State<ProductsPage> {
  final List<Products> _products = <Products>[];
  bool hasInternet = true;
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
    listenForProducts();
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

  Future<void> _refresh_products() async {
    setState(() {});

    try {
      List<Products> products = await getProducts();
      setState(() {
        _products.clear();
        _products.addAll(products);
      });
    } catch (e) {
      // Handle error if any
      setState(() {});
    }
  }

  void listenForProducts() async {
    try {
      List<Products> products = await getProducts();
      setState(() {
        _products.addAll(products);
         _isLoading = false;
      });
    } catch (e) {
      // Handle error if any
    }
  }

  void _filter_products(String query) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          FloatingActionButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewProduct(),
              ),
            );
          },
          child: const Text("New"),),
            IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
             _refresh_products();
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductsSearchDelegate(_products, _filter_products),
              );
            },
          ),
         
        ],),
      body: RefreshIndicator(
        onRefresh: _refresh_products,
        child: hasInternet
            ?  _isLoading // modify this line
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) => ProductsTile(_products[index]),
              )
            : const Center(
                child: Text("No internet access"),
              ),
      ),
    );
  }
}

class ProductsSearchDelegate extends SearchDelegate<Products> {
  final List<Products> _products;
  final Function(String) onSearch;

  ProductsSearchDelegate(this._products, this.onSearch);

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
    final List<Products> suggestions = query.isEmpty
        ? []
        : _products
            .where(
                (tsumo) => tsumo.description.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => ProductsTile(suggestions[index]),
    );
  }

  @override
  set query(String value) {
    super.query = value;
    onSearch(value);
  }
}
