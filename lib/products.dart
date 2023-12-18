import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String image;
  final double value;
  final String nutriscore;
  final int rating;
  final String manufacturer;
  final String note;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.value,
    required this.nutriscore,
    required this.rating,
    required this.manufacturer,
    required this.note,
  });
}


class ProductView extends StatelessWidget {
  final Product product;

  ProductView({required this.product});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('ID: ${product.id}'),
          Text('Product Name: ${product.name}'),
          Text('Rating: ${product.rating}'),
        ],
      ),
      children: [
        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.image),// to repair
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Manufacturer: ${product.manufacturer}'),
                    Text('Nutriscore: ${product.nutriscore}'),
                    Text('Note: ${product.note}'),
                    // to fill with more details
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Products {
  List<Product> _products = [];

  void addProduct(Product product) {
    _products.add(product);
  }

  List<Product> getAllProducts() {
    return List.from(_products);
  }

  Product getProductById(String id) {
    return _products.firstWhere((product) => product.id == id, orElse: () => throw Exception('Product not found'));
  }

  Product getProductByName(String name) {
    return _products.firstWhere((product) => product.name == name, orElse: () => throw Exception('Product not found'));
  }

  List<Product> getProductsByRating(int rating) {
    return _products.where((product) => product.rating == rating).toList();
  }

  List<Widget> getProductViews() {
    return _products.map((product) => ProductView(product: product)).toList();
  }
}