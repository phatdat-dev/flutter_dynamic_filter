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
          final result = _filterEngineSortOrder(fields.map((e) => FieldSortOrder(e, OrderByOperator.ascending)).toSet());

          final dataWantToTest = {
            "0": {"Name": "Alice Bob", "Age": 100, "Date": "2024-07-14T13:35:42.137"},
            "1": {"Name": "Alice Charlie", "Age": 97, "Date": "2024-07-07T13:35:42.137"},
            "210": {"Name": "Liam Sara", "Age": 24, "Date": null},
            "211": {"Name": "Liam Uma", "Age": null, "Date": "2024-07-14T13:35:42.135"},
            "300": {"Name": "Quinn Wendy", "Age": null, "Date": "2024-07-19T13:35:42.135"},
            "305": {"Name": "Ryan Bob", "Age": 99, "Date": "2024-07-09T13:35:42.136"},
            "350": {"Name": "Tom Yara", "Age": 20, "Date": "2024-06-30T13:35:42.135"},
            "459": {"Name": "Zane Xander", "Age": 58, "Date": "2024-06-24T13:35:42.137"},
            "460": {"Name": "Zane Yara", "Age": 107, "Date": "2024-07-21T13:35:42.136"},
            "498": {"Name": null, "Age": 109, "Date": "2024-07-02T13:35:42.136"},
            "499": {"Name": null, "Age": 116, "Date": "2024-07-17T13:35:42.135"}
          };

          dataWantToTest.forEach((key, value) {
            fields.forEach((field) {
              final originValue = result[int.parse(key)][field.name];
              if (field.name == "Date") {
                expect(originValue, DateTime.tryParse(value[field.name]?.toString() ?? ""));
              } else {
                expect(originValue, value[field.name]);
              }
            });
          });
        },
      );
      test(
        "Sort [Name]-[Age]-[Date] ${OrderByOperator.descending.label}",
        () {
          final result = _filterEngineSortOrder(fields.map((e) => FieldSortOrder(e, OrderByOperator.descending)).toSet());

          final dataWantToTest = {
            "0": {"Name": null, "Age": 116, "Date": "2024-07-17T13:35:42.135"},
            "1": {"Name": null, "Age": 109, "Date": "2024-07-02T13:35:42.136"},
            "210": {"Name": "Quinn Hank", "Age": 79, "Date": "2024-06-30T13:35:42.135"},
            "211": {"Name": "Quinn Grace", "Age": 81, "Date": "2024-07-06T13:35:42.135"},
            "300": {"Name": "Liam Ivy", "Age": 117, "Date": "2024-07-16T13:35:42.137"},
            "305": {"Name": "Liam Eva", "Age": 117, "Date": "2024-07-06T13:35:42.137"},
            "350": {"Name": "Jane Bob", "Age": 58, "Date": "2024-07-16T13:35:42.136"},
            "459": {"Name": "Dave Noah", "Age": 97, "Date": "2024-06-26T13:35:42.137"},
            "460": {"Name": "Dave John", "Age": 81, "Date": "2024-07-02T13:35:42.136"},
            "498": {"Name": "Alice Charlie", "Age": 97, "Date": "2024-07-07T13:35:42.137"},
            "499": {"Name": "Alice Bob", "Age": 100, "Date": "2024-07-14T13:35:42.137"}
          };

          dataWantToTest.forEach((key, value) {
            fields.forEach((field) {
              final originValue = result[int.parse(key)][field.name];
              if (field.name == "Date") {
                expect(originValue, DateTime.tryParse(value[field.name]?.toString() ?? ""));
              } else {
                expect(originValue, value[field.name]);
              }
            });
          });
        },
      );
    },
  );
}

List<Map<String, dynamic>> _filterEngineSortOrder(Set<FieldSortOrder> sortOrders) {
  final filterEngine = FilterEngine(
    data: _data,
    sortOrders: sortOrders,
  );
  final result = filterEngine.sortList();
  return result;
}
