import 'package:flutter/material.dart';

import 'package:shopping_list/features/home/data/models/product.dart';

class ProductListViewCustom extends StatelessWidget {
  const ProductListViewCustom({
    super.key,
    required this.products,
    required this.deleteProduct,
  });

  final List<Product> products;
  final void Function(int index) deleteProduct;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        Product product = products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text(
            '\$${(product.price / 100).toStringAsFixed(2)} • ${product.category}',
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => deleteProduct(index),
          ),
        );
      },
    );
  }
}
