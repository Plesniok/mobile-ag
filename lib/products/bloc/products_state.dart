part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final Products products;

  ProductsLoaded({required this.products});
}
