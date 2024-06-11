import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/products/bloc/products_bloc.dart';
import 'package:project_app/products/models/minimal_product.dart';
import 'package:project_app/products/models/products.dart';
import 'package:project_app/products/widgets/add_product_form_dialog.dart';
import 'package:project_app/products/widgets/products_list.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    context.read<ProductsBloc>().add(LoadProductsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Products'),
          ),
          body: const Center(
            child: Center(
              child: ProductsList(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              MinimalProduct? productData = await showDialog<MinimalProduct>(
                context: context,
                builder: (BuildContext context) => AddProductFormDialog(),
              );
              if (productData != null) {
                context
                    .read<ProductsBloc>()
                    .add(AddProduct(minimalProductData: productData));
              }
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
