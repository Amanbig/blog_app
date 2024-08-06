import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  CustomSearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          print("Search input: $value"); // Debug print
          onChanged(value);
        },
        style: TextStyle(color: Colors.white), // Set text color to white
        decoration: InputDecoration(
          labelText: 'Search',
          labelStyle: TextStyle(color: Colors.white), // Set label text color to white
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          fillColor: Colors.black,
          filled: true,
        ),
      ),
    );
  }
}
