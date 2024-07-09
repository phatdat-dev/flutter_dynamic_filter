import 'package:flutter_dynamic_filter/flutter_dynamic_filter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../ultils.dart';

late final List<Map<String, dynamic>> _data;
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    _data = await loadExampleData();
  });

  // filter 1 column

  group(
    "Sort by [Name]",
    () {
      const String fieldName = 'Name';
      test(
        "Sort [$fieldName] ${OrderByOperator.ascending.label}",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(Field(name: fieldName, type: FieldType.Text), OrderByOperator.ascending),
          });

          final dataWantToTest = {
            "0": "Alice Bob",
            "1": "Alice Charlie",
            "210": "Liam Sara",
            "211": "Liam Uma",
            "300": "Quinn Wendy",
            "305": "Ryan Bob",
            "350": "Tom Yara",
            "459": "Zane Xander",
            "460": "Zane Yara",
            "498": null,
            "499": null
          };

          dataWantToTest.forEach((key, value) {
            expect(result[int.parse(key)][fieldName], value);
          });
        },
      );
      test(
        "Sort [$fieldName] ${OrderByOperator.descending.label}",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(Field(name: fieldName, type: FieldType.Text), OrderByOperator.descending),
          });

          final dataWantToTest = {
            "0": null,
            "1": null,
            "210": "Quinn Hank",
            "211": "Quinn Grace",
            "300": "Liam Ivy",
            "305": "Liam Eva",
            "350": "Jane Bob",
            "459": "Dave Noah",
            "460": "Dave John",
            "498": "Alice Charlie",
            "499": "Alice Bob"
          };

          dataWantToTest.forEach((key, value) {
            expect(result[int.parse(key)][fieldName], value);
          });
        },
      );
    },
  );

  group(
    "Sort by [Age]",
    () {
      const String fieldName = 'Age';
      test(
        "Sort [$fieldName] ${OrderByOperator.ascending.label}",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(Field(name: fieldName, type: FieldType.Number), OrderByOperator.ascending),
          });

          final dataWantToTest = {
            "0": 18,
            "1": 18,
            "210": 63,
            "211": 63,
            "300": 83,
            "305": 84,
            "350": 93,
            "459": 116,
            "460": 116,
            "498": null,
            "499": null
          };

          dataWantToTest.forEach((key, value) {
            expect(result[int.parse(key)][fieldName], value);
          });
        },
      );
      test(
        "Sort [$fieldName] ${OrderByOperator.descending.label}",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(Field(name: fieldName, type: FieldType.Number), OrderByOperator.descending),
          });

          final dataWantToTest = {
            "0": null,
            "1": null,
            "210": 81,
            "211": 80,
            "300": 59,
            "305": 58,
            "350": 48,
            "459": 25,
            "460": 25,
            "498": 18,
            "499": 18
          };

          dataWantToTest.forEach((key, value) {
            expect(result[int.parse(key)][fieldName], value);
          });
        },
      );
    },
  );

  group(
    "Sort by [Date]",
    () {
      const String fieldName = 'Date';
      test(
        "Sort [$fieldName] ${OrderByOperator.ascending.label}",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(Field(name: fieldName, type: FieldType.Date), OrderByOperator.ascending),
          });

          final dataWantToTest = {
            "0": "2024-06-24T13:35:42.135",
            "1": "2024-06-24T13:35:42.136",
            "210": "2024-07-07T13:35:42.136",
            "211": "2024-07-07T13:35:42.137",
            "300": "2024-07-13T13:35:42.136",
            "305": "2024-07-14T13:35:42.135",
            "350": "2024-07-17T13:35:42.135",
            "459": null,
            "460": null,
            "498": null,
            "499": null
          };

          dataWantToTest.forEach((key, value) {
            expect(result[int.parse(key)][fieldName], DateTime.tryParse(value ?? ""));
          });
        },
      );
      test(
        "Sort [$fieldName] ${OrderByOperator.descending.label}",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(Field(name: fieldName, type: FieldType.Date), OrderByOperator.descending),
          });

          final dataWantToTest = {
            "0": null,
            "1": null,
            "210": "2024-07-12T13:35:42.137",
            "211": "2024-07-12T13:35:42.137",
            "300": "2024-07-07T13:35:42.135",
            "305": "2024-07-07T13:35:42.135",
            "350": "2024-07-04T13:35:42.136",
            "459": "2024-06-27T13:35:42.135",
            "460": "2024-06-26T13:35:42.137",
            "498": "2024-06-24T13:35:42.136",
            "499": "2024-06-24T13:35:42.135",
          };

          dataWantToTest.forEach((key, value) {
            expect(result[int.parse(key)][fieldName], DateTime.tryParse(value ?? ""));
          });
        },
      );
    },
  );
}

// Printt.white(jsonEncode(_getResultTest(result, fieldName)));
Map<String, dynamic> _getResultTest(List<Map<String, dynamic>> result, String key) {
  return {
    "0": result[0][key],
    "1": result[1][key],
    "210": result[210][key],
    "211": result[211][key],
    "300": result[300][key],
    "305": result[305][key],
    "350": result[350][key],
    "459": result[459][key],
    "460": result[460][key],
    "498": result[498][key],
    "499": result[499][key],
  };
}

List<Map<String, dynamic>> _filterEngineSortOrder(Set<FieldSortOrder> sortOrders) {
  final filterEngine = FilterEngine(
    data: _data,
    sortOrders: sortOrders,
  );
  final result = filterEngine.sortList();
  return result;
}
