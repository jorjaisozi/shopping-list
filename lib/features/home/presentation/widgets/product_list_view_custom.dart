import 'package:flutter/material.dart';

import 'package:shopping_list/features/home/data/product.dart';

class ProductListViewCustom extends StatelessWidget {
  const ProductListViewCustom({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        Product product = products[index];
        return ListTile(title: Text(product.name));
      },
    );
  }
}
