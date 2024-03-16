import 'package:egerecords/models/expenseModel.dart';
import 'package:egerecords/pages/expenses/new_exp.dart';
import 'package:egerecords/repository/expense_repository.dart';
import 'package:egerecords/widgets/expenses_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => __ExpensesPageStateState();
}

class __ExpensesPageStateState extends State<ExpensesPage> {
  final List<Expenses> _expenses = <Expenses>[];
  bool hasInternet = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
    listenForexpenses();
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

  Future<void> _refresh_expenses() async {
    setState(() {});

    try {
      List<Expenses> expenses = await getExpenses();
      setState(() {
        _expenses.clear();
        _expenses.addAll(expenses);
      });
    } catch (e) {
      // Handle error if any
      setState(() {});
    }
  }

  void listenForexpenses() async {
    try {
      List<Expenses> expenses = await getExpenses();
      setState(() {
        _expenses.addAll(expenses);
        _isLoading = false;
      });
    } catch (e) {
      // Handle error if any
    }
  }

  void _filter_expenses(String query) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expenses"), actions: [
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewExpense(),
              ),
            );
          },
          child: const Text("New"),
        ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
             _refresh_expenses();
            },
          ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: expensesSearchDelegate(_expenses, _filter_expenses),
            );
          },
        ),
      ]),
      body: RefreshIndicator(
        onRefresh: _refresh_expenses,
        child: hasInternet
            ? _isLoading // modify this line
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: _expenses.length,
                    itemBuilder: (context, index) =>
                        ExpensesTile(_expenses[index]),
                  )
            : const Center(
                child: Text("No internet access"),
              ),
      ),
    );
  }
}

class expensesSearchDelegate extends SearchDelegate<Expenses> {
  final List<Expenses> _expenses;
  final Function(String) onSearch;

  expensesSearchDelegate(this._expenses, this.onSearch);

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
    final List<Expenses> suggestions = query.isEmpty
        ? []
        : _expenses
            .where((tsumo) =>
                tsumo.description.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => ExpensesTile(suggestions[index]),
    );
  }

  @override
  set query(String value) {
    super.query = value;
    onSearch(value);
  }
}
