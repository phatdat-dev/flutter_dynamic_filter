import 'dart:convert';

import 'package:flutter_dynamic_filter/flutter_dynamic_filter.dart';
import 'package:flutter_dynamic_filter/src/shared/utils/print.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../ultils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    _data = await loadExampleData();
  });

  // filter 1 column

  group(
    "Sort by [Name]",
    () {
      final field = Field(name: 'Name', type: FieldType.Text);
      test(
        "Sort [${field.name}] ${OrderByOperator.ascending.label}",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(field, OrderByOperator.ascending),
          });

          final dataWantToTest = {
            "0": null,
            "1": null,
            "210": "John Mia",
            "211": "John Mia",
            "300": "Olivia Yara",
            "305": "Peter Charlie",
            "350": "Ryan Quinn",
            "459": "Xander Sara",
            "460": "Xander Vince",
            "498": "Zane Xander",
            "499": "Zane Yara",
          };

          testCase(
            fields: {field},
            dataWantToTest: dataWantToTest,
            result: result,
          );
        },
      );
      test(
        "Sort [${field.name}] ${OrderByOperator.descending.label}",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(field, OrderByOperator.descending),
          });

          final dataWantToTest = {
            "0": "Zane Yara",
            "1": "Zane Xander",
            "210": "Olivia Noah",
            "211": "Olivia Kate",
            "300": "Jane Wendy",
            "305": "Jane Kate",
            "350": "Hank Zane",
            "459": "Alice Charlie",
            "460": "Alice Bob",
            "498": null,
            "499": null,
          };

          testCase(
            fields: {field},
            dataWantToTest: dataWantToTest,
            result: result,
          );
        },
      );
    },
  );

  group(
    "Sort by [Age]",
    () {
      final field = Field(name: 'Age', type: FieldType.Number);
      test(
        "Sort [${field.name}] ${OrderByOperator.ascending.label}",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(field, OrderByOperator.ascending),
          });

          final dataWantToTest = {
            "0": null,
            "1": null,
            "210": 53,
            "211": 53,
            "300": 74,
            "305": 76,
            "350": 87,
            "459": 105,
            "460": 106,
            "498": 117,
            "499": 117,
          };

          testCase(
            fields: {field},
            dataWantToTest: dataWantToTest,
            result: result,
          );
        },
      );
      test(
        "Sort [${field.name}] ${OrderByOperator.descending.label}",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(field, OrderByOperator.descending),
          });

          final dataWantToTest = {
            "0": 117,
            "1": 117,
            "210": 72,
            "211": 71,
            "300": 50,
            "305": 49,
            "350": 40,
            "459": 19,
            "460": 18,
            "498": null,
            "499": null,
          };

          testCase(
            fields: {field},
            dataWantToTest: dataWantToTest,
            result: result,
          );
        },
      );
    },
  );

  group(
    "Sort by [Date]",
    () {
      final field = Field(name: 'Date', type: FieldType.Date);
      test(
        "Sort [${field.name}] ${OrderByOperator.ascending.label}",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(field, OrderByOperator.ascending),
          });

          final dataWantToTest = {
            "0": null,
            "1": null,
            "210": "2024-07-04T13:35:42.137",
            "211": "2024-07-04T13:35:42.137",
            "300": "2024-07-10T13:35:42.135",
            "305": "2024-07-10T13:35:42.136",
            "350": "2024-07-13T13:35:42.136",
            "459": "2024-07-20T13:35:42.137",
            "460": "2024-07-20T13:35:42.137",
            "498": "2024-07-23T13:35:42.137",
            "499": "2024-07-23T13:35:42.137",
          };

          testCase(
            fields: {field},
            dataWantToTest: dataWantToTest,
            result: result,
          );
        },
      );
      test(
        "Sort [${field.name}] ${OrderByOperator.descending.label}",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(field, OrderByOperator.descending),
          });

          final dataWantToTest = {
            "0": "2024-07-23T13:35:42.137",
            "1": "2024-07-23T13:35:42.137",
            "210": "2024-07-09T13:35:42.136",
            "211": "2024-07-09T13:35:42.136",
            "300": "2024-07-04T13:35:42.136",
            "305": "2024-07-04T13:35:42.135",
            "350": "2024-07-01T13:35:42.136",
            "459": null,
            "460": null,
            "498": null,
            "499": null,
          };

          testCase(
            fields: {field},
            dataWantToTest: dataWantToTest,
            result: result,
          );
        },
      );
    },
  );

  group(
    "Sort by [Name]-[Age]-[Date]",
    () {
      final Set<Field> fields = {
        Field(name: "Name", type: FieldType.Text),
        Field(name: "Age", type: FieldType.Number),
        Field(name: "Date", type: FieldType.Date),
      };

      test(
        "Sort [Name]-[Age]-[Date] ${OrderByOperator.ascending.label}",
        () {
          final result = _filterEngineSortOrder(
            fields.map((e) => FieldSortOrder(e, OrderByOperator.ascending)).toSet(),
          );

          final dataWantToTest = <String, Map<String, dynamic>>{
            "0": {"Name": null, "Age": 21, "Date": "2024-07-10T13:35:42.137"},
            "1": {"Name": null, "Age": 21, "Date": "2024-07-19T13:35:42.136"},
            "210": {
              "Name": "John Mia",
              "Age": 52,
              "Date": "2024-06-28T13:35:42.135",
            },
            "211": {
              "Name": "John Mia",
              "Age": 72,
              "Date": "2024-07-22T13:35:42.137",
            },
            "300": {
              "Name": "Olivia Yara",
              "Age": 43,
              "Date": "2024-06-29T13:35:42.137",
            },
            "305": {"Name": "Peter Charlie", "Age": 63, "Date": null},
            "350": {
              "Name": "Ryan Quinn",
              "Age": 86,
              "Date": "2024-07-07T13:35:42.136",
            },
            "459": {
              "Name": "Xander Sara",
              "Age": 31,
              "Date": "2024-06-25T13:35:42.135",
            },
            "460": {
              "Name": "Xander Vince",
              "Age": 81,
              "Date": "2024-06-25T13:35:42.136",
            },
            "498": {
              "Name": "Zane Xander",
              "Age": 58,
              "Date": "2024-06-24T13:35:42.137",
            },
            "499": {
              "Name": "Zane Yara",
              "Age": 107,
              "Date": "2024-07-21T13:35:42.136",
            },
          };

          testCase(
            fields: fields,
            dataWantToTest: dataWantToTest,
            result: result,
          );
        },
      );
      test(
        "Sort [Name]-[Age]-[Date] ${OrderByOperator.descending.label}",
        () {
          final result = _filterEngineSortOrder(
            fields.map((e) => FieldSortOrder(e, OrderByOperator.descending)).toSet(),
          );

          final dataWantToTest = <String, Map<String, dynamic>>{
            "0": {
              "Name": "Zane Yara",
              "Age": 107,
              "Date": "2024-07-21T13:35:42.136",
            },
            "1": {
              "Name": "Zane Xander",
              "Age": 58,
              "Date": "2024-06-24T13:35:42.137",
            },
            "210": {
              "Name": "Olivia Noah",
              "Age": 37,
              "Date": "2024-06-27T13:35:42.137",
            },
            "211": {
              "Name": "Olivia Kate",
              "Age": 103,
              "Date": "2024-07-09T13:35:42.137",
            },
            "300": {
              "Name": "Jane Wendy",
              "Age": 45,
              "Date": "2024-07-02T13:35:42.136",
            },
            "305": {
              "Name": "Jane Kate",
              "Age": 51,
              "Date": "2024-07-12T13:35:42.135",
            },
            "350": {
              "Name": "Hank Zane",
              "Age": 45,
              "Date": "2024-06-25T13:35:42.135",
            },
            "459": {
              "Name": "Alice Charlie",
              "Age": 97,
              "Date": "2024-07-07T13:35:42.137",
            },
            "460": {
              "Name": "Alice Bob",
              "Age": 100,
              "Date": "2024-07-14T13:35:42.137",
            },
            "498": {"Name": null, "Age": 21, "Date": "2024-07-19T13:35:42.136"},
            "499": {"Name": null, "Age": 21, "Date": "2024-07-10T13:35:42.137"},
          };

          testCase(
            fields: fields,
            dataWantToTest: dataWantToTest,
            result: result,
          );
        },
      );
      test(
        "Sort [Name] Asc -[Age] Desc -[Date] Asc",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(fields.elementAt(0), OrderByOperator.ascending),
            FieldSortOrder(fields.elementAt(1), OrderByOperator.descending),
            FieldSortOrder(fields.elementAt(2), OrderByOperator.ascending),
          });

          final dataWantToTest = <String, Map<String, dynamic>>{
            "0": {"Name": null, "Age": 116, "Date": "2024-07-17T13:35:42.135"},
            "1": {"Name": null, "Age": 109, "Date": "2024-07-02T13:35:42.136"},
            "210": {
              "Name": "John Mia",
              "Age": 72,
              "Date": "2024-07-22T13:35:42.137",
            },
            "211": {
              "Name": "John Mia",
              "Age": 52,
              "Date": "2024-06-28T13:35:42.135",
            },
            "300": {
              "Name": "Olivia Yara",
              "Age": 43,
              "Date": "2024-06-29T13:35:42.137",
            },
            "305": {"Name": "Peter Charlie", "Age": 63, "Date": null},
            "350": {
              "Name": "Ryan Quinn",
              "Age": 86,
              "Date": "2024-07-07T13:35:42.136",
            },
            "459": {
              "Name": "Xander Sara",
              "Age": 31,
              "Date": "2024-06-25T13:35:42.135",
            },
            "460": {
              "Name": "Xander Vince",
              "Age": 104,
              "Date": "2024-07-04T13:35:42.135",
            },
            "498": {
              "Name": "Zane Xander",
              "Age": 58,
              "Date": "2024-06-24T13:35:42.137",
            },
            "499": {
              "Name": "Zane Yara",
              "Age": 107,
              "Date": "2024-07-21T13:35:42.136",
            },
          };

          testCase(
            fields: fields,
            dataWantToTest: dataWantToTest,
            result: result,
          );
        },
      );
      test(
        "Sort [Age] Asc -[Name] Desc -[Date] Desc",
        () {
          final result = _filterEngineSortOrder({
            FieldSortOrder(fields.elementAt(1), OrderByOperator.ascending),
            FieldSortOrder(fields.elementAt(0), OrderByOperator.descending),
            FieldSortOrder(fields.elementAt(2), OrderByOperator.descending),
          });

          final dataWantToTest = <String, Map<String, dynamic>>{
            "0": {
              "Name": "Yara Tom",
              "Age": null,
              "Date": "2024-06-30T13:35:42.137",
            },
            "1": {
              "Name": "Yara Peter",
              "Age": null,
              "Date": "2024-07-17T13:35:42.137",
            },
            "210": {
              "Name": "Eva Xander",
              "Age": 53,
              "Date": "2024-07-10T13:35:42.135",
            },
            "211": {"Name": null, "Age": 53, "Date": "2024-07-13T13:35:42.135"},
            "300": {
              "Name": "John Frank",
              "Age": 74,
              "Date": "2024-07-04T13:35:42.136",
            },
            "305": {
              "Name": "Wendy Eva",
              "Age": 76,
              "Date": "2024-06-26T13:35:42.136",
            },
            "350": {
              "Name": "Zane Charlie",
              "Age": 87,
              "Date": "2024-07-15T13:35:42.135",
            },
            "459": {
              "Name": "Alice Grace",
              "Age": 105,
              "Date": "2024-07-09T13:35:42.135",
            },
            "460": {
              "Name": "Peter Charlie",
              "Age": 106,
              "Date": "2024-07-02T13:35:42.136",
            },
            "498": {
              "Name": "Liam Ivy",
              "Age": 117,
              "Date": "2024-07-16T13:35:42.137",
            },
            "499": {
              "Name": "Liam Eva",
              "Age": 117,
              "Date": "2024-07-06T13:35:42.137",
            },
          };

          testCase(
            fields: fields,
            dataWantToTest: dataWantToTest,
            result: result,
          );
        },
      );
    },
  );
}

late final List<Map<String, dynamic>> _data;

void testCase({
  required Set<Field> fields,
  required Map<String, dynamic> dataWantToTest,
  required List<Map<String, dynamic>> result,
}) {
  const bool getLogDataTest = false;
  final runtimeData = Map.from(dataWantToTest);

  dataWantToTest.forEach((key, value) {
    fields.forEach((field) {
      final originValue = result[int.parse(key)][field.name];

      if (getLogDataTest) {
        if (value is Map) {
          value.forEach((key2, value2) {
            if (field.name == key2) runtimeData[key]?[key2] = (originValue is DateTime ? originValue.toIso8601String() : originValue) as Object?;
          });
        } else {
          runtimeData[key] = originValue is DateTime ? originValue.toIso8601String() : originValue;
        }
      }

      if (field.type == FieldType.Date) {
        if (value is Map) {
          expect(
            originValue,
            DateTime.tryParse(value[field.name]?.toString() ?? ""),
          );
        } else {
          expect(originValue, DateTime.tryParse(value ?? ""));
        }
      } else {
        if (value is Map) {
          expect(originValue, value[field.name]);
        } else {
          expect(originValue, value);
        }
      }
    });
  });
  Printt.white(jsonEncode(runtimeData));
}

List<Map<String, dynamic>> _filterEngineSortOrder(
  Set<FieldSortOrder> sortOrders,
) {
  final filterEngine = FilterEngine(
    data: _data,
    sortOrders: sortOrders,
    valueExtractor: (Map<String, dynamic> item, String fieldName) {},
  );
  final result = filterEngine.sortList();
  return result;
}
