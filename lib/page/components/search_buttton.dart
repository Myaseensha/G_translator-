import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.searchQuery,
    required this.onSearchQueryChanged,
  }) : super(key: key);

  final String searchQuery;
  final Function(String) onSearchQueryChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(
          Icons.search,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onChanged: onSearchQueryChanged,
    );
  }
}
