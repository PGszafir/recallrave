import 'package:flutter/material.dart';

class ProductTileView extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  final double value;
  final String nutriscore;
  final int rating;
  final String manufacturer;
  final String note;

  ProductTileView({
    required this.id,
    required this.name,
    required this.image,
    required this.value,
    required this.nutriscore,
    required this.rating,
    required this.manufacturer,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      margin: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        child: ExpansionTile(
          title: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$name",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        rating,
                            (index) => Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          children: [
            ListTile(
              title: Text("Value: $value"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nutriscore: $nutriscore\nManufacturer: $manufacturer"),
                  SizedBox(height: 8.0),
                  Text(
                    "Note: $note",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              trailing: Image.asset(image),
            ),
          ],
        ),
      ),
    );
  }
}
