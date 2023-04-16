class LanguageElement {
  final String language;

  LanguageElement({
    required this.language,
  });

  factory LanguageElement.fromJson(Map<String, dynamic> json) {
    return LanguageElement(
      language: json['language'],
    );
  }
}
