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
  TextEditingController ratingController = TextEditingController(); // Added this line
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
              style: TextStyle(color: Colors.grey.shade300),
              decoration: InputDecoration(
                labelText: 'Product name',
                labelStyle: TextStyle(color: Colors.grey.shade300),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            SizedBox(height: 22.0),
            Text(
              'Photo',
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 4.0),
            GestureDetector(
              onTap: _getImage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _image != null
                        ? Image.file(
                      _image!,
                      width: double.infinity,
                      height: 100.0,
                      fit: BoxFit.cover,
                    )
                        : Icon(
                      Icons.add_a_photo,
                      size: 100.0,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
            TextField(
              controller: valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true), // set numeric input
              style: TextStyle(color: Colors.grey.shade300),
              decoration: InputDecoration(
                labelText: 'Product value',
                labelStyle: TextStyle(color: Colors.grey.shade300),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            SizedBox(height: 22.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Nutriscore',
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    5,
                        (index) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Handle the Nutriscore selection (you can update a variable or call a function)
                          final nutriscore = String.fromCharCode('A'.codeUnitAt(0) + index);
                          print('Selected Nutriscore: $nutriscore');
                          setState(() {
                            nutriscoreController.text = nutriscore;
                          });
                        },
                        child: Container(
                          height: 40.0,
                          margin: (index == 0)
                              ? EdgeInsets.only(right: 4.0) // No left margin for the first tile
                              : (index == 4)
                              ? EdgeInsets.only(left: 4.0) // No right margin for the last tile
                              : EdgeInsets.symmetric(horizontal: 4.0), // Margins for middle tiles
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: nutriscoreController.text.isNotEmpty &&
                                nutriscoreController.text ==
                                    String.fromCharCode('A'.codeUnitAt(0) + index)
                                ? Colors.grey.shade200
                                : Colors.grey.shade500,
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode('A'.codeUnitAt(0) + index),
                              style: TextStyle(
                                color: nutriscoreController.text.isNotEmpty &&
                                    nutriscoreController.text ==
                                        String.fromCharCode('A'.codeUnitAt(0) + index)
                                    ? Colors.black
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 22.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Rating',
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    10,
                        (index) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Handle the rating selection (you can update a variable or call a function)
                          print('Selected Rating: ${index + 1}');
                          setState(() {
                            ratingController.text = (index + 1).toString();
                          });
                        },
                        child: Container(
                          height: 40.0,
                          margin: (index == 0)
                              ? EdgeInsets.only(right: 4.0) // No left margin for the first tile
                              : (index == 9)
                              ? EdgeInsets.only(left: 4.0) // No right margin for the last tile
                              : EdgeInsets.symmetric(horizontal: 4.0), // Margins for middle tiles
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: ratingController.text.isNotEmpty &&
                                int.parse(ratingController.text) == index + 1
                                ? Colors.grey.shade200
                                : Colors.grey.shade500,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: ratingController.text.isNotEmpty &&
                                    int.parse(ratingController.text) == index + 1
                                    ? Colors.black
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: manufacturerController,
              style: TextStyle(color: Colors.grey.shade300),
              decoration: InputDecoration(
                labelText: 'Manufacturer',
                labelStyle: TextStyle(color: Colors.grey.shade300),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            TextField(
              controller: noteController,
              style: TextStyle(color: Colors.grey.shade300),
              decoration: InputDecoration(
                labelText: 'Note',
                labelStyle: TextStyle(color: Colors.grey.shade300),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            SizedBox(height: 22.0),
            ElevatedButton(
              onPressed: () {
                addProduct();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade300,
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
    // use Products.addProduct
    print('New Product: $newProduct');

    // navigate back to the previous screen
    Navigator.pop(context);
  }
}
