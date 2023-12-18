import 'package:flutter/material.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({Key? key}) : super(key: key);

  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController nutriscoreController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Add Product"),
      ),
      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: imageController,
              decoration: InputDecoration(labelText: 'Image URL'),// to replace with camera or gallery chose
            ),
            TextField(
              controller: valueController,
              decoration: InputDecoration(labelText: 'Product Value'),
            ),
            TextField(
              controller: nutriscoreController,
              decoration: InputDecoration(labelText: 'Nutriscore'),// to upgrade add scanning option
            ),
            TextField(
              controller: ratingController,
              decoration: InputDecoration(labelText: 'Rating'),// replace with numbers input
            ),
            TextField(
              controller: manufacturerController,
              decoration: InputDecoration(labelText: 'Manufacturer'),
            ),
            TextField(
              controller: noteController,
              decoration: InputDecoration(labelText: 'Note'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                addProduct();
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }

  void addProduct() {
    // Validate the data before adding the product
    if (nameController.text.isEmpty ||
        imageController.text.isEmpty ||
        valueController.text.isEmpty ||
        nutriscoreController.text.isEmpty ||
        ratingController.text.isEmpty ||
        manufacturerController.text.isEmpty) {
      // Show an error message or handle validation accordingly toast
      return;
    }

    // Create a new product
    Map<String, dynamic> newProduct = {
      "product": {
        "name": nameController.text,
        "image": imageController.text,
        "value": double.parse(valueController.text),
        "nutriscore": nutriscoreController.text,
        "rating": int.parse(ratingController.text),
        "manufacturer": manufacturerController.text,
        "note": noteController.text,
      }
    };

    // Add the new product to the list and save it to a json file
    print('New Product: $newProduct');

    // navigate back to the previous screen
    Navigator.pop(context);
  }
}