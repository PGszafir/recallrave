import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recallrave/add_product_view.dart';
import 'package:recallrave/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const TextStyle appBarTextStyle = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    // Dodaj więcej stylów według potrzeb
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecallRave',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey, // Use grey as the background
          backgroundColor: Colors.grey[600], // Use grey as the primary color
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          headline6: appBarTextStyle,
        ),
      ),
      home: const MyHomePage(title: 'RecallRave'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final String data =
    await rootBundle.loadString('assets/products.json');
    setState(() {
      products = List<Map<String, dynamic>>.from(json.decode(data)['products']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(
          child: Text(widget.title, style: MyApp.appBarTextStyle),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //children: myProductView,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[400], // Jasnoszary kolor dla tła ramki
                  borderRadius: BorderRadius.circular(8.0), // Opcjonalnie: dodaj zaokrąglone rogi
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/bar_split.png',
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: 16.0), // Opcjonalne: Dodaj odstęp między obrazem a tekstem
                    Text(
                      "App for collecting memories about products, those that delighted you and those you didn't like...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            for (final product in products) // iterate for product list and add product view
              ListTile(
                // replace this with the product view
                title: Text(product['name']),
                subtitle: Text(product['manufacturer']),
                leading: Image.asset(product['image']),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductView()),
          );
        },
        tooltip: 'Open Add Product View',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ad here or in other file product viev

