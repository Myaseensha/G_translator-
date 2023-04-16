import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/language_get_model.dart';

Future<List<LanguageElement>> loadLanguages() async {
  const String endpoint =
      'https://google-translate1.p.rapidapi.com/language/translate/v2/languages';
  final headers = {
    'content-type': 'application/x-www-form-urlencoded',
    'Accept-Encoding': 'application/gzip',
    'X-RapidAPI-Key': 'fa2cce298emsh26efabd3854a611p180ab9jsn21739d2bb072',
    'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
  };

  try {
    final response = await http.get(Uri.parse(endpoint), headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> languagesJson = jsonResponse['data']['languages'];
      final languages =
          languagesJson.map((lang) => LanguageElement.fromJson(lang)).toList();
      return languages;
    } else {
      throw Exception('Failed to fetch supported languages');
    }
  } catch (e) {
    throw Exception('Failed to fetch supported languages: $e');
  }
}
