import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<Map<String, dynamic>>> loadExampleData() async {
  return List.from(jsonDecode((await rootBundle.loadString('packages/flutter_dynamic_filter/assets/example_data/data.json')))).map((e) {
    try {
      final tryParseDateTime = DateTime.tryParse(e['Date']);
      if (tryParseDateTime != null) e['Date'] = tryParseDateTime;
      // ignore: empty_catches
    } catch (e) {}
    return Map<String, dynamic>.from(e);
  }).toList();
}
