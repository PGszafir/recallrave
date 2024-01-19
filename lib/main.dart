import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recallrave/add_product_view.dart';
import 'package:recallrave/products.dart';
import 'package:recallrave/product_view.dart';
import 'package:recallrave/search_component.dart';

void main() async{
  runApp(const MyApp());
  await Products().loadProductsFromJson();
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
  Products productsList = Products();

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadProducts() async {
    Products().loadProductsFromJson();
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
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9, // 90% szerokości ekranu
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Jasnoszary kolor dla tła ramki
                    borderRadius: BorderRadius.circular(8.0), // Opcjonalnie: dodaj zaokrąglone rogi
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Wyśrodkuj treść w pionie
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
            ),
            SearchComponent(),
            ProductTileView( // testowy obiekt czy wogóle się wyświetla
              id: 1,
              name: "wino białe",
              manufacturer: "jeronimo",
              image: "assets/assets",
              value: 10,
              nutriscore: "A",
              rating: 3,
              note: "some note xdd",
            ),
            for (final product in products)// do przekazania prawdziwa lista produktów bo to nie działa
              ProductTileView(
                id: product['id'],
                name: product['name'],
                manufacturer: product['manufacturer'],
                image: product['image'],
                value: product['value'],
                nutriscore: product['nutriscore'],
                rating: product['rating'],
                note:product['note'],
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                // button action here dodajcie sobie tutaj bo nie ogarniam jak do końca dać 2 taki pływające przyciski
              },
              icon: Icon(Icons.refresh),
              tooltip: 'refresh Products',
            ),
          ],
        ),
      ),
     );
  }
}


