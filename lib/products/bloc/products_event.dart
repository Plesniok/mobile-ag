part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class LoadProductsEvent extends ProductsEvent {}

class AddProduct extends ProductsEvent {
  final MinimalProduct minimalProductData;

  AddProduct({
    required this.minimalProductData
  });
}

class RemoveProduct extends ProductsEvent {
  final Product productData;

  RemoveProduct({
    required this.productData
  });
}
