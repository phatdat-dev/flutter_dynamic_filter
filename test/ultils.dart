import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<Map<String, dynamic>>> loadExampleData() async {
  return List.from(jsonDecode((await rootBundle.loadString('packages/flutter_dynamic_filter/assets/example_data/data.json')))).map((e) {
    try {
      final tryParseDateTime = DateTime.tryParse(e['Date']);
      if (tryParseDateTime != null) e['Date'] = tryParseDateTime;
    } catch (e) {}
    return Map<String, dynamic>.from(e);
  }).toList();
}

/// ```dart
/// Printt.white(jsonEncode(getResultTest(result, [fieldName])));
/// ```
Map<String, dynamic> getResultTest(List<Map<String, dynamic>> result, List<String> keys) {
  if (keys.isEmpty) return {};
  final indexs = [0, 1, 210, 211, 300, 305, 350, 459, 460, 498, 499];
  final Map<String, dynamic> data = {};
  if (keys.length == 1) {
    indexs.forEach((index) {
      data["$index"] = result[index][keys.first];
    });
  } else {
    indexs.forEach((index) {
      data["$index"] = {};
      keys.forEach((key) {
        final value = result[index][key];
        data["$index"][key] = tryParseDateTimeString(value);
      });
    });
  }
  return data;
}

dynamic tryParseDateTimeString(dynamic value) {
  DateTime? tryParseDateTime;
  try {
    tryParseDateTime = DateTime.tryParse(value.toString());
  } catch (e) {}

  return tryParseDateTime?.toIso8601String() ?? value;
}
