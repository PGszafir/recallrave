import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:recallrave/main.dart';


class Product {
  final int id;
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
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "value": value,
      "nutriscore": nutriscore,
      "rating": rating,
      "manufacturer": manufacturer,
      "note": note,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      value: json['value'],
      nutriscore: json['nutriscore'],
      rating: json['rating'],
      manufacturer: json['manufacturer'],
      note: json['note'],
    );
  }
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
                  image: NetworkImage(product.image),// add reali image of product
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

  static final Products _singleton = Products._internal();

  factory Products(){
    return _singleton;
  }

  Products._internal();

  int getListLen(){
    return _products.length;
  }
  Future<String> getPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> getFileRef() async {
    final path = await getPath();
    return File('$path/products.json');
  }

  Future<void> loadProductsFromJson() async {
    File file = await getFileRef();
    String contents = await file.readAsString();
    var jsonResponse = jsonDecode(contents);
    for (var p in jsonResponse) {
      if(p['id'] >= getListLen()) {
        Product product = Product(id: p['id'],
            name: p['name'],
            image: p['image'],
            value: p['value'],
            nutriscore: p['nutriscore'],
            rating: p['rating'],
            manufacturer: p['manufacturer'],
            note: p['note']);
        _products.add(product);
      }
    }
  }

  void addProduct(Product product) async {
    _products.add(product);
    saveListToFile();
  }

  void saveListToFile() async {
    final file = await getFileRef();
    List<Product> tempList = List.from(_products);
    tempList.map((product) => product.toJson(),).toList();
    file.writeAsString(json.encode(tempList));
  }

  List<Product> getAllProducts() {
    print(_products);
    return _products;
  }

  Product getProductById(String id) {
    return _products.firstWhere((product) => product.id == id, orElse: () => throw Exception('Product not found'));
  }

  Product getProductByName(String name) {
    return _products.firstWhere((product) => product.name == name, orElse: () => throw Exception('Product not found'));
  }

  List<Product> getProductsBySearchKey(String searchKey) {
    searchKey = searchKey.trim().toLowerCase();
    return _products.where((product) => product.name.toLowerCase().contains(searchKey)).toList();
  }

  List<Product> getProductsByRating(int rating) {
    return _products.where((product) => product.rating == rating).toList();
  }

  List<Widget> getProductViews() {
    return _products.map((product) => ProductView(product: product)).toList();
  }
}