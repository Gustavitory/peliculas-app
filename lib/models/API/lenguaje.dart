enum OriginalLanguage { EN, HI, ES }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "hi": OriginalLanguage.HI,
  "es": OriginalLanguage.ES
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
