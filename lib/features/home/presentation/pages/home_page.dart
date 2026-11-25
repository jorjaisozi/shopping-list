import 'package:flutter/material.dart';

import 'package:shopping_list/features/home/data/models/product.dart';
import 'package:shopping_list/features/home/presentation/widgets/add_product_dialog_custom.dart';
import 'package:shopping_list/features/home/presentation/widgets/product_list_view_custom.dart';

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

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  Future<void> _showAddProductDialogCustom() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AddProductDialogCustom(addProduct: _addProduct);
      },
    );
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
          : ProductListViewCustom(
              products: _products,
              deleteProduct: _deleteProduct,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialogCustom,
        tooltip: 'Add product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
