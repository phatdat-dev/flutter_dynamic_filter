import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_dynamic_filter/flutter_dynamic_filter.dart';

class ExampleData {
  static final fields = [
    Field(name: 'Name'),
    Field(name: 'Age', type: FieldType.Number),
    Field(name: 'Phone', type: FieldType.Text),
    Field(name: 'Address', type: FieldType.Text),
    Field(name: 'Date', type: FieldType.Date),
    Field(name: 'Status', type: FieldType.SingleSelect),
  ];
  static Future<List<Map<String, dynamic>>> loadExampleData() async {
    return List.from(jsonDecode((await rootBundle.loadString('packages/flutter_dynamic_filter/assets/example_data/data.json')))).map((e) {
      try {
        final tryParseDateTime = DateTime.tryParse(e['Date']);
        if (tryParseDateTime != null) e['Date'] = tryParseDateTime;
        // ignore: empty_catches
      } catch (e) {}
      return Map<String, dynamic>.from(e);
    }).toList();
  }

  static List<Map<String, dynamic>> generateExampleData() {
    // Create a list of example data
    final List<Map<String, dynamic>> exampleDataList = [];
    final random = Random();

    // List of random names
    final names = [
      "John",
      "Jane",
      "Alice",
      "Bob",
      "Charlie",
      "Dave",
      "Eva",
      "Frank",
      "Grace",
      "Hank",
      "Ivy",
      "Jack",
      "Kate",
      "Liam",
      "Mia",
      "Noah",
      "Olivia",
      "Peter",
      "Quinn",
      "Ryan",
      "Sara",
      "Tom",
      "Uma",
      "Vince",
      "Wendy",
      "Xander",
      "Yara",
      "Zane",
    ];
    final status = ["Active", "Pending", "Deleted", "Banned", "Draft"];
    final street = ["Main", "First", "Second", "Third", "Fourth", "Park", "Oak", "Pine", "Elm", "Maple"];
    final streetType = ["St", "Ave", "Blvd", "Cir", "Ct", "Dr", "Ln", "Pkwy", "Rd", "St", "Way"];
    final city = ["Anytown", "Otherville", "Someburg", "Everycity", "Nowhere", "Uptown", "Downtown", "Outatown"];

    for (int i = 1; i <= 500; i++) {
      final data = <String, dynamic>{
        "Name": "${names[random.nextInt(names.length)]} ${names[random.nextInt(names.length)]}",
        "Age": random.nextInt(100) + 18, // Tuổi từ 18 đến 117
        "Phone": "${random.nextInt(1000).toString().padLeft(3, '0')}-${random.nextInt(10000).toString().padLeft(4, '0')}",
        "Address":
            "${random.nextInt(1000) + 1} ${street[random.nextInt(street.length)]} ${streetType[random.nextInt(streetType.length)]}, ${city[random.nextInt(city.length)]}",
        "Date": DateTime.now().add(Duration(days: random.nextInt(30) - 15)),
        "Status": status[random.nextInt(status.length)],
      };

      // random null value
      if (random.nextBool()) {
        data[data.keys.elementAt(random.nextInt(fields.length))] = null;
      }

      exampleDataList.add(data);
    }
    return exampleDataList;
  }
}
