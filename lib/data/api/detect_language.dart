import 'package:dio/dio.dart';

Future<String> detectLanguage(String text) async {
  const String endpoint =
      'https://google-translate1.p.rapidapi.com/language/translate/v2/detect';
  final headers = {
    'content-type': 'application/x-www-form-urlencoded',
    'Accept-Encoding': 'application/gzip',
    'X-RapidAPI-Key': 'fa2cce298emsh26efabd3854a611p180ab9jsn21739d2bb072',
    'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
  };
  const sam = 'hello';
  final body = {'q': text ??= sam};
  final response = await Dio()
      .post(endpoint, data: body, options: Options(headers: headers));
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = response.data;
    final String language =
        jsonResponse['data']['detections'][0][0]['language'];
    return language;
  } else {
    throw Exception('Failed to detect language');
  }
}
