import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/products/bloc/products_bloc.dart';
import 'package:project_app/products/models/minimal_product.dart';
import 'package:project_app/products/models/product.dart';
import 'package:project_app/products/widgets/add_product_form_dialog.dart';

class ProductWidget extends StatefulWidget {
  final Product productData;

  const ProductWidget({super.key, required this.productData});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  void initState() {
    context.read<ProductsBloc>().add(LoadProductsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.productData.id.toString()),
      onDismissed: (direction) {
        context
            .read<ProductsBloc>()
            .add(RemoveProduct(productData: widget.productData));
      },
      background: Container(
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.errorContainer,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Icon(Icons.delete),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    widget.productData.name ?? "-",
                    style: Theme.of(context).primaryTextTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    (widget.productData.price ?? "-").toString(),
                    style: Theme.of(context).primaryTextTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .secondaryContainer, // Set the color of the border
                    width: 5.0, // Set the width of the border
                  ),
                ),
              ),
              child: Row(),
            ),
            SizedBox(
              height: 150,
              child: Container(
                margin: EdgeInsetsDirectional.symmetric(vertical: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  widget.productData.description ?? "No description provided",
                  style: Theme.of(context).primaryTextTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
