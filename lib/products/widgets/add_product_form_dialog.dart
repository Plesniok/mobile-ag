import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:project_app/products/bloc/products_bloc.dart';
import 'package:project_app/products/models/minimal_product.dart';
import 'package:project_app/products/models/product.dart';
import 'package:project_app/products/models/products.dart';

class AddProductFormDialog extends StatefulWidget {
  const AddProductFormDialog({super.key});

  @override
  _AddProductFormDialogState createState() => _AddProductFormDialogState();
}

class _AddProductFormDialogState extends State<AddProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

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
              controller: _productNameController,
              decoration:
                  const InputDecoration(labelText: 'Product productName'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product description';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Double Value'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                } else if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              var productsBox = Hive.box('products');
              Products products =
                  productsBox.get('products') ?? Products(products: []);

              final int newProductId = products.getLastProductId() + 1;

              final double? parsedPrice =
                  double.tryParse(_priceController.text);

              if (parsedPrice == null) {
                Navigator.of(context).pop();
                return;
              }

              Navigator.of(context).pop(MinimalProduct(name: _productNameController.text, description: _descriptionController.text, price: parsedPrice));
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
