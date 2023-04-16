import 'package:dio/dio.dart';

Future<String> translate(
    String text, String sourceLangCode, String targetLangCode) async {
  const String endpoint =
      'https://google-translate1.p.rapidapi.com/language/translate/v2';
  final headers = {
    'content-type': 'application/x-www-form-urlencoded',
    'Accept-Encoding': 'application/gzip',
    'X-RapidAPI-Key': 'fa2cce298emsh26efabd3854a611p180ab9jsn21739d2bb072',
    'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
  };
  final data = {
    'q': text,
    'source': sourceLangCode,
    'target': targetLangCode,
  };
  final dio = Dio(BaseOptions(headers: headers));
  try {
    final response = await dio.post(endpoint, data: data);
    if (response.statusCode == 200) {
      print("poliiiiiiiiiiiiii");
      final Map<String, dynamic> jsonResponse = response.data;
      final String translatedText =
          jsonResponse['data']['translations'][0]['translatedText'];

      print(translatedText);
      return translatedText;
    } else {
      return "Sorry brooooooooooo........";
    }
  } catch (e) {
    throw Exception('Failed to translate text: $e');
  }
}
