import 'dart:convert';

class Stats {
  Map<String, int> countries;
  Map<String, int> sources;

  Stats({required this.countries, required this.sources});

  factory Stats.fromJson(Map<String, dynamic> json) {
    Map<String, int> resultMap = {};
    json['countries'].forEach((key, value) {
      resultMap[key] = int.parse(value.toString());
    });

    Map<String, int> resultMapSource = {};
    json['source'].forEach((key, value) {
      resultMapSource[key] = int.parse(value.toString());
    });

    return Stats(countries: resultMap, sources: resultMapSource);
  }
}
