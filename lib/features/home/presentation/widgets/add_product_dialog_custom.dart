import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shopping_list/features/home/data/models/product.dart';

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
  var _category = 'Others';

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
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'The product name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _productPriceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the product price',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'The product price is required';
                }
                if (double.tryParse(value)! < 0) {
                  return 'Enter a valid price';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'String',
              ),
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                _category = value!;
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a _category';
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
                  name: _productNameController.text.trim(),
                  price: (double.tryParse(_productPriceController.text)! * 100)
                      .round(),
                  category: _category,
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
