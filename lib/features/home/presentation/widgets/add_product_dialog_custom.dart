import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shopping_list/features/home/data/product.dart';

class AddProductDialogCustom extends StatefulWidget {
  const AddProductDialogCustom({super.key, required this.addProduct});

  final void Function(Product product) addProduct;

  @override
  State<AddProductDialogCustom> createState() => _AddProductDialogCustomState();
}

class _AddProductDialogCustomState extends State<AddProductDialogCustom> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();

  @override
  void dispose() {
    _productNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add product'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autofocus: true,
              controller: _productNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the product name',
                labelText: 'Product name',
              ),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'The product name is required';
                }
                return null;
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              autofocus: true,
              controller: _productPriceController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the product price',
                labelText: 'Product price',
              ),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'The product price is required';
                }
                if (double.tryParse(value)! < 0) {
                  return 'The product price cannot be less than zero';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.addProduct(
                Product(
                  name: _productNameController.text,
                  price:
                      ((double.tryParse(_productPriceController.text))! * 100)
                          .round(),
                ),
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
