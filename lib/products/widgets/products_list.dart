import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/products/bloc/products_bloc.dart';
import 'package:project_app/products/models/minimal_product.dart';
import 'package:project_app/products/models/product.dart';
import 'package:project_app/products/widgets/add_product_form_dialog.dart';
import 'package:project_app/products/widgets/product_widget.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  void initState() {
    context.read<ProductsBloc>().add(LoadProductsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
      if (state is ProductsLoaded) {
        return ListView.builder(
            itemCount: state.products.products.length,
            itemBuilder: (context, index) {
              return ProductWidget(productData: state.products.products[index]);
            });
      }

      return Center(
          child: Text(
        "No data loaded",
      ));
    });
  }
}
