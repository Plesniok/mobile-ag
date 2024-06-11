import 'package:project_app/products/models/product.dart';

class Products {
  final List<Product> products;

  Products({required this.products});
  
  factory Products.fromJson(Map<String, dynamic> json) {
    var productsList = json['products'] as List;
    List<Product> products = productsList.map((i) => Product.fromJson(i)).toList();
    return Products(products: products);
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((e) => e.toJson()).toList(),
    };
  }

  int getLastProductId() {
    return products.length;
  }
}
