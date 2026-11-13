import 'package:flutter/material.dart';

import 'package:shopping_list/features/home/data/product.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Product> _products = [];

  void _addProduct(Product product) {
    setState(() {
      _products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _products.isEmpty
          ? Center(
              child: Text(
                'No products yet',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          : Center(
              child: Text(
                _products.last.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _addProduct(Product(name: 'Product ${_products.length + 1}')),
        tooltip: 'Add product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
