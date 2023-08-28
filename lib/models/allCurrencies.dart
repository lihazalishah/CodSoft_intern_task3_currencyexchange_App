import 'dart:convert';

Map<String, String> allcurrenciesFromJson(String body) =>
    Map.from(json.decode(body))
        .map((key, value) => MapEntry<String, String>(key, value));

String allcurrenciesToJson(Map<String, String> body) => json.encode(
    Map.from(body).map((key, value) => MapEntry<String, dynamic>(key, value)));
