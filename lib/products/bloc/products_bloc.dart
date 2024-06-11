import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_app/products/models/minimal_product.dart';
import 'package:project_app/products/models/product.dart';
import 'package:project_app/products/models/products.dart';

part 'products_event.dart';
part 'products_state.dart';

Future<File> _getLocalFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File('${directory.path}/data.json');
}

Future<Products> _initializeFileWithEmptyProducts() async {
  final file = await _getLocalFile();
  final products = Products(products: []);
  final jsonData = json.encode(products.toJson());
  await file.writeAsString(jsonData);
  return products;
}

Future<Products> _readProducts() async {
  try {
    final file = await _getLocalFile();
    if (await file.exists()) {
      final contents = await file.readAsString();
      final jsonData = json.decode(contents);
      return Products.fromJson(jsonData);
    } else {
      _initializeFileWithEmptyProducts();
      return Products(products: []);
    }
  } catch (e) {
    return Products(products: []);
  }
}

String generateRandomString() {
  const String chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random.secure(); // Secure random generator
  return List.generate(20, (index) => chars[random.nextInt(chars.length)])
      .join();
}

Future<File> _writeProducts(Products products) async {
  final file = await _getLocalFile();
  final jsonData = json.encode(products.toJson());
  return file.writeAsString(jsonData);
}

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<LoadProductsEvent>((event, emit) async {
      Products products = await _readProducts();
      emit(ProductsLoaded(products: products));
    });

    on<AddProduct>((event, emit) async {
      Products products = await _readProducts();

      products.products.add(Product(
          id: generateRandomString(),
          name: event.minimalProductData.name,
          description: event.minimalProductData.description,
          price: event.minimalProductData.price));

      await _writeProducts(products);

      emit(ProductsLoaded(products: products));
    });

    on<RemoveProduct>((event, emit) async {
      Products products = await _readProducts();

      products.products
          .removeWhere((Product product) => product.id == event.productData.id);

      await _writeProducts(products);

      emit(ProductsLoaded(products: products));
    });
  }
}
