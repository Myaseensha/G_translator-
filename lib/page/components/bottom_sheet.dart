import 'package:flutter/material.dart';
import 'package:translator_clone/data/model/language_get_model.dart';
import 'package:translator_clone/page/components/language_list.dart';
import '../../data/api/languages_get.dart';
import '../../page/components/search_buttton.dart';

class LanguageSelectionScreen extends StatefulWidget {
  final Function(String) onLanguageSelected;

  const LanguageSelectionScreen({super.key, required this.onLanguageSelected});

  @override
  LanguageSelectionScreenState createState() => LanguageSelectionScreenState();
}

class LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String searchQuery = '';
  TextStyle bold = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "From",
            style: bold,
          ),
          const SizedBox(
            height: 10,
          ),
          SearchBar(
            searchQuery: searchQuery,
            onSearchQueryChanged: (query) {
              setState(() {
                searchQuery = query;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "All Languages",
            style: bold,
          ),
          Expanded(
            child: FutureBuilder<List<LanguageElement>>(
              future: loadLanguages(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final languages = snapshot.data!
                      .map((lang) => LanguageElement(language: lang.language))
                      .toList();
                  final filteredLanguages = languages
                      .where((lang) =>
                          languagNames[lang.language]
                              ?.toLowerCase()
                              ?.contains(searchQuery.toLowerCase()) ??
                          false)
                      .toList();
                  return ListView.builder(
                    itemCount: filteredLanguages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        key: UniqueKey(),
                        title: Text(
                          languagNames[filteredLanguages[index].language]!,
                          style: bold,
                        ),
                        onTap: () {
                          widget.onLanguageSelected(
                            filteredLanguages[index].language,
                          );
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
