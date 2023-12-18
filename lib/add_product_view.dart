import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({Key? key}) : super(key: key);

  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController nutriscoreController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  late File? _image = null;

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Add Product",
          style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: 20.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            GestureDetector(
              onTap: _getImage,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: _image != null
                    ? Image.file(
                  _image!,
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                )
                    : Icon(
                  Icons.add_a_photo,
                  size: 50.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: valueController,
              decoration: InputDecoration(labelText: 'Product Value', labelStyle: TextStyle(color: Colors.white)),
            ),
            TextField(
              controller: nutriscoreController,
              decoration: InputDecoration(labelText: 'Nutriscore', labelStyle: TextStyle(color: Colors.white)),// to upgrade add scanning option
            ),
            TextField(
              controller: ratingController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Rating', labelStyle: TextStyle(color: Colors.white)),// replace with numbers input
            ),
            TextField(
              controller: manufacturerController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Manufacturer', labelStyle: TextStyle(color: Colors.white)),
            ),
            TextField(
              controller: noteController,
              decoration: InputDecoration(labelText: 'Note', labelStyle: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                addProduct();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[400],
                onPrimary: Colors.black,
              ),
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
        //imageController.text.isEmpty ||
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
        "image": _image?.path,
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
