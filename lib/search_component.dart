import 'package:flutter/material.dart';

class SearchComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Wpisz wyszukiwane słowo...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 16.0),
          ElevatedButton(
            onPressed: () {
              // Obsługa logiki wyszukiwania
            },
            child: Text("Szukaj"),
          ),
        ],
      ),
    );
  }
}
